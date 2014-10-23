express = require 'express'
request = require 'request'
async = require 'async'
config = require 'config'

app = express()

sendRequest = (url, cb) ->
  request url, (err, res, body) ->
    cb null, body

###
  # ##Example
  # `logger.info( 'info', 'Test Log Message', { anything: 'This is metadata' } );`
  # `logger.log( 'info', 'Test Log Message', { anything: 'This is metadata' } );`
  # ###Logging Levels
  # verbose, info, http, warn, err, silent
###
logger = new (winston.Logger)(transports: [
  new (winston.transports.Console)({ level: 'info' })
  new (winston.transports.File)(filename: "stdout.log")
])

app.get '/', (req, res) ->

  async.concat config.urls, sendRequest, (err, results) ->
    if err then logger.error 'index - stream request ', err
    res.send results

module.exports = app
