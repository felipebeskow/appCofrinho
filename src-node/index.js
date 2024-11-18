require('dotenv').config();
const app = require('./app');
const cors = require('cors');
const port = process.env.PORT
app.use(cors({
    origin: '*'
}));
app.listen(port)
console.log("Servidor rodando, porta: "+port)