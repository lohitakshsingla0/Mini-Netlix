const { response } = require("express");
const express = require("express")
const pool = require('../db')
const router = new express.Router();


const addPerson = (request, response) => {
   const { person_name, dob, sex, cv } = request.body;

   pool.query("select add_person($1, $2, $3, $4);", [person_name, dob, sex, cv], (err, res) => {
       if (err) {
           throw err
       }
       response.status(201).send('Person added...')
   })
}

const deletePerson = (request, response) => {
    pool.query("select delete_person($1);", [request.params.id], (err, res) => {
        if (err) {
            throw err
        }
        response.send('Person successfully deleted')
    })
}

router.post('/person', addPerson)
router.delete('/person/:id', deletePerson)



module.exports = router