const express = require('express')
const pool = require('../db')
const Router = express.Router()
const bodyParser = require('body-parser')
const cookieParser = require('cookie-parser')


const app = express();

app.use(cookieParser());
app.use(bodyParser.urlencoded({extended: true}))

const getUserData = async (request, response) => {
    try {

        // console.log('Cookies: ', request.cookies['username'])
        // // Cookies that have been sig
        //  console.log(cookie)
        const users = await pool.query("select get_all_users();") 
        if (!users) {
            response.status(400).send('Not Found...!')
        }
        response.send(users)
        // console.log(rating)
    } catch (err) {
        response.status(500).send(err)
    }
}

Router.get('/user', getUserData)

module.exports = Router
