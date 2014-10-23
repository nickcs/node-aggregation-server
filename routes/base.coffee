request = require 'request'
async = require 'async'
config = require 'config'

_sendRequest = (url, cb) ->
  request url, (err, res, body) ->
    cb null, body

concatDownStreams = (req, res) ->
  async.concat config.urls, _sendRequest, (err, results) ->
    if err then logger.error "Base: URL request - ", err
    res.send results

module.exports.concatDownStreams = concatDownStreams
