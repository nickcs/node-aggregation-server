request = require 'request'
async = require 'async'
config = require 'config'

_sendRequest = (url, cb) ->
  request url, (err, res, body) ->
    cb null, body

exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/'
    handler: (request, reply) ->
      async.concat config.urls, _sendRequest, (err, results) ->
        if err
          plugin.log ['error'], 'Base: URL request - ' + err
        reply(results)

  next()

exports.register.attributes =
    name: 'rootPlugin',
    version: '0.0.1'
