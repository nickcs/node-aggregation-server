aggregation = require '../lib/aggregation'

exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/'
    handler: (request, reply) ->
      aggregation.aggregateRequests options.registrations, (err, results) ->
        reply results

  plugin.route
    method: 'POST'
    path: '/'
    handler: (request, reply) ->
      console.log request.payload.question.answers
      reply()
  next()

exports.register.attributes =
    name: 'rootPlugin',
    version: '0.0.1'
