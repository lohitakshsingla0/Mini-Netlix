const { request, response } = require('express')
const express = require('express')
const { append } = require('express/lib/response')
const res = require('express/lib/response')
const async = require('hbs/lib/async')
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
    const { movie_id, genre_id} = request.body
    pool.query("select add_genres_to_movies($1, $2);", [movie_id, genre_id], (err, res) => {
        if (err) {
            throw err
        }
        response.status(201).send('Added!')
    })
}

/* All the Apis are moved to append.js which is entry point of project */

// const getMovieRelatedPerson = async (request, response) => {
//     try {
//         const persons = await pool.query("select get_movie_related_person($1);", [request.params.id])
//         if (!persons) {
//             response.status(400).send("Data not Found!")
//         }
//         response.send(persons)
//         console.log(persons)
//     } catch (err) {
//         response.status(500).send('Server Error!...')
//     }
// }

// const getSubordinate = async (request, response) => {
//     try {
//         const movies = await pool.query("select get_subordinate_movies($1);", [request.params.id])
//         if (!movies) {
//             response.status(400).send("Data not Found!")
//         }
//         response.send(movies)
//     } catch (err) {
//         response.status(500).send('Server Error!...')
//     }
// }

// const getSuggestedMovie = async (request, response) => {
    
//     try {
//         const movies = await pool.query("select suggestion_movies($1);", [request.params.id])
//         if (!movies) {
//             res.status(400).send('not found...')
//         }
//         response.send(movies)
//     } catch (err) {
//         response.status(500).send(err)
//     }
// }

router.post('/movie', addMovie)
router.post('/movie/genre', addGenresMovie)
// router.get('/movieperson/:id', getMovieRelatedPerson)
// router.get('/moviesubordinate/:id', getSubordinate)
// router.get('/moviesuggestion/:id', getSuggestedMovie)

module.exports = router
