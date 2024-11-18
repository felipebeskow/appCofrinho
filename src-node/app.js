const express = require('express');
const bodyParser = require('body-parser');
const route = require('./routes/route');
const cors = require('cors');
const app = express();
app.use(bodyParser.json());
app.use(cors({
    origin: '*'
}))
app.use(express.static('public'))
app.use('/api/', route)
module.exports = app