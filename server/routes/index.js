var express = require('express')
var router = express.Router()
var path = require('path')

/* GET data for app. */
router.get('/data', function(req, res, next) {
  res.set('Content-Type', 'application/json')
  res.send('{"message":"here\'s some json"}')
})


module.exports = router
