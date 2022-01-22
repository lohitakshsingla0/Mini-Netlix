var mysql = require("mysql");
var con = mysql.createPool({
  user: "lohitaksh_rw",
  database: "lohitaksh",
  password: "aex3Hahgane",
  port: 5432,
  host: "pgsql.hrz.tu-chemnitz.de",
});

console.log(con);
/*con.connect(function(err){
    if(err){
      console.log(err);
      return;
    }
    console.log('Connection established');
  });
//module.exports = { pool };*/