const Category = require('../controller/category');
const fileUpload = require('../controller/fileUpload');
const Spend = require('../controller/spend');
const wallet = require('../controller/wallet');
const multer = require('multer');

const upload = multer();
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
route.post('/upload', upload.single('file'), fileUpload.post)
module.exports = route;