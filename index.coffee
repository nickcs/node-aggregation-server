express = require 'express'
request = require 'request'
async = require 'async'
config = require 'config'

app = express()

sendRequest = (url, cb) ->
  request url, (err, res, body) ->
     cb null, body

app.get '/', (req, res) ->

  async.concat config.urls, sendRequest, (err, results) ->
    if err then console.log err
    res.send results

module.exports = app
