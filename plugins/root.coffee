rootController = require '../controller/root-controller'


exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/'
    handler: (request, reply) ->
      rootController.getStreams request, reply

  next()

exports.register.attributes =
    name: 'rootPlugin',
    version: '0.0.1'
