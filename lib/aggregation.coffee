fs = require 'fs'
request = require 'request'
async = require 'async'

_sendRequest = (registration, cb) ->

  options =
    method: registration.method
    uri: registration.endPoint

  fs.readFile 'lib/430pm.hum', (err, data) ->
    if registration.contentType == 'application/json'
      options.json = true
      options.body =
        method: 'glossary'
        phrase: data.toString()

    request options, (err, res, body) ->
      cb null, body

module.exports.aggregateRequests = (registrations, cb) ->
  async.concat registrations, _sendRequest, (err, results) ->
    if err
      plugin.log ['error'], 'Base: URL request - ' + err

    cb err, results
