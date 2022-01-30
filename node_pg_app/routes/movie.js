const { request, response } = require('express')
const express = require('express')
const pool = require('../db')
const router = new express.Router()

const addMovie = (request, response) => {
    const {id, title, release_year, min_age, prod_country} = request.body
    pool.query("select add_movie($1, $2, $3, $4, $5);", [ id, title, release_year, min_age, prod_country ], (err, res) => {
        if (err) {
            throw err
        }
        response.status(201).send('Movie successfully added!')
    })
}

const addGenresMovie = (request, response) => {
    
}

router.post('/movie', addMovie)

module.exports = router
