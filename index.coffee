express = require 'express'
config = require 'config'
baseRoute = require './routes/base'
registrationRoute = require './routes/registration'

app = express()

app.get '/', baseRoute.concatDownStreams

app.get '/register', registrationRoute.getRequirements

module.exports = app
