const Category = require('../controller/category');
const Spend = require('../controller/spend');
const wallet = require('../controller/wallet');

const route = require('express').Router();
//rotas publicas
//redireciona para o front-end
route.get('/', async (req, res) => {
    // res.writeHead(301, {'Location': process.env.FRONT_PATH}).end()
    res.send('oi')
})
route.post('/spend', Spend.post)
route.post('/category', Category.post)
route.get('/category', Category.get)
route.post('/wallet', wallet.post)
route.get('/wallet', wallet.get)
module.exports = route;