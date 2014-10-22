express = require 'express'
request = require 'request'
async = require 'async'

app = express()

sendRequest = (url, cb) ->
  request url, (err, res, body) ->
     cb null, body

app.get '/', (req, res) ->

  async.concat ['http://ip.jsontest.cm/','http://date.jsontest.com/'], sendRequest, (err, results) ->
    res.send results

module.exports = app
