config = require 'config'

Hapi = require 'hapi'
Good = require 'good'
Lout = require 'lout'

root = require './plugins/root'
registration = require './plugins/registration'

server = new Hapi.Server '0.0.0.0', process.env.PORT || config.port

module.exports.startServer = (cb) ->

  server.pack.register [
      {plugin: Good}
      {plugin: Lout}
      {
        plugin: root
        options:
          registrations: config.registrations
      }
      {plugin: registration}
    ],
    (err) ->
      if err
        throw err

      server.start ->
        cb(null, server)
