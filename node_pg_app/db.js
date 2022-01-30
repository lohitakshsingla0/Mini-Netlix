
const { Pool, Client } = require('pg')
const pool = new Pool({
  user: "lohitaksh_rw",
  database: "lohitaksh",
  password: "aex3Hahgane",
  port: 5432,
  host: "pgsql.hrz.tu-chemnitz.de",
})




pool.query("SELECT delete_person(15);", (err, res) => {
  console.log(err, res)
  pool.end()
})


module.exports = pool
