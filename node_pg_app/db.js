
const { Pool, Client } = require('pg')
const pool = new Pool({
  user: "lohitaksh_rw",
  database: "lohitaksh",
  password: "aex3Hahgane",
  port: 5432,
  host: "pgsql.hrz.tu-chemnitz.de",
})




pool.query('SELECT hello();', (err, res) => {
  console.log(err, res)
  pool.end()
})


























/*
const client = new Client({
  user: "lohitaksh_rw",
  database: "lohitaksh",
  password: "aex3Hahgane",
  port: 5432,
  host: "pgsql.hrz.tu-chemnitz.de",
})
client.connect()
client.query('SELECT NOW()', (err, res) => {
  console.log(err, res)
  client.end()
})*/