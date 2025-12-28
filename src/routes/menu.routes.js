const router = require('express').Router();
const auth = require('../middleware/auth.middleware');
const { getMenus } = require('../controllers/menu.controller');

router.get('/', auth, getMenus);

module.exports = router;
