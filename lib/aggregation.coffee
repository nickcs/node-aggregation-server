_ = require 'lodash'
fs = require 'fs'
request = require 'request'
async = require 'async'

_sendRequest = (registration, cb) ->

  options =
    method: registration.method
    uri: registration.endPoint
    json: registration.contentType == 'application/json'

  fs.readFile 'lib/430pm.hum', (err, text) ->
    params = registration.requiredParams

    _.each _.keys(params), (key) ->
      if params[key] == 'text'
        params[key] = text.toString()
      else if params[key] == '?'
        params[key] = 'when was the world created'
      else if params[key] == 'url'
        params[key] = 'https://cs-aggregator.herokuapp.com/callback'

    if options.json
      options.body = params

    request options, (err, res, body) ->
      cb null, body

module.exports.aggregateRequests = (registrations, cb) ->
  async.concat registrations, _sendRequest, (err, results) ->
    if err
      plugin.log ['error'], 'Base: URL request - ' + err

    cb err, results
