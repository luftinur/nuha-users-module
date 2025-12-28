const db = require('../config/database');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');

const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    const userRes = await db.query(
      'SELECT * FROM users WHERE "username"=$1 AND status=1',
      [username]
    );

    if (!userRes.rows.length)
      return res.status(401).json({ msg: 'User not found' });

    const user = userRes.rows[0];

    const valid = await bcrypt.compare(password, user.password);
    if (!valid)
      return res.status(401).json({ msg: 'Wrong password' });

    const roleRes = await db.query(`
      SELECT r.id, r.name 
      FROM roles r
      JOIN user_roles ur ON ur."roleid" = r.id
      WHERE ur."userid"=$1
    `, [user.id]);

    // 🚩 MULTI ROLE → RETURN TEMP TOKEN
    if (roleRes.rows.length > 1) {
      const tempToken = jwt.sign(
        { user_id: user.id, partial_auth: true },
        process.env.JWT_SECRET,
        { expiresIn: '10m' }
      );

      return res.json({
        status: 'choose_role',
        session_token: tempToken,
        roles: roleRes.rows
      });
    }

    // ✅ SINGLE ROLE → DIRECT REAL TOKEN
    const token = jwt.sign(
      { user_id: user.id, role_id: roleRes.rows[0].id },
      process.env.JWT_SECRET,
      { expiresIn: '8h' }
    );

    res.json({ status: 'success', token });

  } catch (err) {
    console.error(err);
    res.status(500).json({ msg: 'Server error' });
  }
};

const selectRole = async (req, res) => {
  try {
    const header = req.headers.authorization;
    if (!header) return res.status(401).json({ msg: 'Session token missing' });

    const tempToken = header.split(' ')[1];
    const decoded = jwt.verify(tempToken, process.env.JWT_SECRET);

    if (!decoded.partial_auth)
      return res.status(403).json({ msg: 'Invalid session token' });

    const { role_id } = req.body;

    const check = await db.query(
      'SELECT 1 FROM user_roles WHERE "userid"=$1 AND "roleid"=$2',
      [decoded.user_id, role_id]
    );

    if (!check.rows.length)
      return res.status(403).json({ msg: 'Role not assigned' });

    const token = jwt.sign(
      { user_id: decoded.user_id, role_id },
      process.env.JWT_SECRET,
      { expiresIn: '8h' }
    );

    res.json({ status: 'success', token });

  } catch (err) {
    console.error(err);
    res.status(401).json({ msg: 'Invalid or expired session token' });
  }
};

module.exports = { login, selectRole };
