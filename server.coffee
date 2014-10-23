config = require 'config'
logger = require './logger'

Hapi = require 'hapi'
Good = require 'good'
Lout = require 'lout'

root = require './plugins/root'
registration = require './plugins/registration'

server = new Hapi.Server 'localhost', process.env.PORT || config.port

logger.info 'App Started - listening at ', server.info.uri

server.pack.register [
    {plugin: Good}
    {plugin: Lout}
    {plugin: root}
    {plugin: registration}
  ],
  (err) ->
    if err
      throw err

    server.start ->
      server.log 'info', 'Server running at: ' + server.info.uri
