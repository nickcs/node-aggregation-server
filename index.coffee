express = require 'express'
config = require 'config'
baseRoute = require './routes/base'

app = express()

app.get '/', baseRoute.concatDownStreams

module.exports = app
