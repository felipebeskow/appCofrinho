const knex = require('knex');
require("dotenv").config();
let config = {
  client: "mysql2",
  connection: {
      host: process.env.DB_HOST,
      port: process.env.DB_PORT,
      database: process.env.DB_DATABASE,
      user: process.env.DB_USER,
      password: process.env.DB_PASSWORD
  }
}
const DbConnection = knex(config);
module.exports = DbConnection;