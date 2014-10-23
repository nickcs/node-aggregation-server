app = require './index'
config = require 'config'
logger = require './logger'

Hapi = require 'hapi'
Good = require 'good'

root = require './plugins/root'
registration = require './plugins/registration'

server = new Hapi.Server 'localhost', process.env.PORT || config.port

logger.info 'App Started - listening at ', server.info.uri

server.pack.register [Good, root, registration], (err) ->
  if err
    throw err

  server.start ->
    server.log 'info', 'Server running at: ' + server.info.uri

server.start()
