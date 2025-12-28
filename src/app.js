require('dotenv').config();

const express = require('express');
const cors = require('cors');

const app = express();

app.use(cors());
app.use(express.json());

app.get('/api', (req, res) => {
    res.json({status: 'API Nuha Users Module'});
});


const authRoutes = require('./routes/auth.routes');
const menuRoutes = require('./routes/menu.routes');


app.use('/api/auth', authRoutes);
app.use('/api/menus', menuRoutes);

const PORT = process.env.APP_PORT || 3000;
app.listen(PORT, () => console.log('Server running on port ' + PORT));
