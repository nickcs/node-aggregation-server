fs = require 'fs'
strHtml = require '../lib/str-html'

exports.register = (plugin, options, next) ->

  fs.readFile 'plugins/requirements.txt', (err, data) ->
    plugin.route
      method: 'POST'
      path: '/register'
      config:
        description: strHtml.strToHtml data.toString(0)
      handler: (request, reply) ->
        reply 'got it'

    next()

exports.register.attributes =
    name: 'registrationPlugin',
    version: '0.0.1'
