aggregation = require '../lib/aggregation'

exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/'
    handler: (request, reply) ->
      aggregation.aggregateRequests options.registrations, (err, results) ->
        reply(results)

  next()

exports.register.attributes =
    name: 'rootPlugin',
    version: '0.0.1'
