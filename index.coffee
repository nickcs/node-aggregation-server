express = require 'express'
request = require 'request'

app = express()

app.get '/', (req, res) ->
  request 'http://www.google.com'
  .pipe request 'http://www.yahoo.com'
  .pipe res

module.exports = app
