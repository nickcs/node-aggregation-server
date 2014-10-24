config    = require 'config'
request   = require 'request'
async     = require 'async'

class RootController

  constructor: (args) ->


  @_sendRequest = (url, cb) ->
    request url, (err, res, body) ->
      cb null, body

  @getStreams =  (err, results) ->
    console.log config.urls
    async.concat @urls, @_sendRequest, (err, results) ->
      if err
        plugin.log ['error'], 'Base: URL request - ' + err
        console.log ['error'], 'Base: URL request - ' + err
      reply results


module.exports = RootController
