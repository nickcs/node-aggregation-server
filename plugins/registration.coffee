exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/register'
    handler: (request, reply) ->
      reply.file('plugins/requirements.txt')

  next()

exports.register.attributes =
    name: 'registrationPlugin',
    version: '0.0.1'
