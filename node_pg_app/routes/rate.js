const express = require('express')
const pool = require('../db')
const router = new express.Router()

const deleteRating = (request, response) => {
    pool.query("select delete_rating($1);", [request.params.id], (err, res) => {
        if (err) {
            throw err
        }
        response.status(201).send('Deleted....')
    })
}

router.delete('/rate/:id', deleteRating)

module.exports = router