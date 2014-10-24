registration = require "../controller/registration-controller"

exports.register = (plugin, options, next) ->
  plugin.route
    method: 'GET'
    path: '/registration'
    config:
      description: "Descriptor for the POST endpoint format"
      handler: registration.readConfig
      # handler: registration.readConfig request, reply, (err,data) ->
      #   return next err if err
      #   reply data

  next()

exports.register.attributes =
    name: 'registrationPlugin',
    version: '0.0.1'
