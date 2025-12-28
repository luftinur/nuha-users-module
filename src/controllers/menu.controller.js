const db = require('../config/database');

function buildTree(data, parentid = null) {
  return data
    .filter(item => item.parentid === parentid)
    .sort((a,b) => a.ordering - b.ordering)
    .map(item => ({
      id: item.id,
      name: item.name,
      path: item.path,
      icon: item.icon,
      children: buildTree(data, item.id)
    }));
}

const getMenus = async (req, res) => {
  try {
    const { role_id } = req.user;

    const result = await db.query(`
      SELECT m.*
      FROM menus m
      JOIN role_menus rm ON rm."menuid" = m.id
      WHERE rm."roleid"=$1
      ORDER BY m.ordering
    `, [role_id]);

    const menus = buildTree(result.rows);
    res.json(menus);
  } catch (err) {
    console.error(err);
    res.status(500).json({ msg: 'Server error' });
  }
};

module.exports = { getMenus };