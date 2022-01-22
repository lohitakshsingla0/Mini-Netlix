const pgp = require('pg-promise')(/* initialization options */);

const cn = {
    user: "lohitaksh_rw",
    database: "lohitaksh",
    password: "aex3Hahgane",
    port: 5432,
    host: "pgsql.hrz.tu-chemnitz.de",
};

// alternative: 
// var cn = 'postgres://username:password@host:port/database';

const db = pgp(cn); // database instance;

// select and return a single user name from id:
db.one('SELECT name FROM users ')
    .then(user => {
        console.log(user.name); // print user name;
    })
    .catch(error => {
        console.log(error); // print the error;
    });

// alternative - new ES7 syntax with 'await':
// await db.one('SELECT name FROM users WHERE id = $1', [123]);