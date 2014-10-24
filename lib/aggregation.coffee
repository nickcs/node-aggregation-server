request = require 'request'
async = require 'async'

_sendRequest = (registration, cb) ->

  request {
    method: registration.method
    uri: registration.endPoint
  },
  (err, res, body) ->
    cb null, body

module.exports.aggregateRequests = (registrations, cb) ->
  async.concat registrations, _sendRequest, (err, results) ->
    if err
      plugin.log ['error'], 'Base: URL request - ' + err

    cb err, results
