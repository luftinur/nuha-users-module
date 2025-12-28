const router = require('express').Router();
const ctrl  = require('../controllers/auth.controller');

router.post('/login', ctrl.login);
router.post('/select-role', ctrl.selectRole);

module.exports = router;
