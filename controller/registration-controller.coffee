fs        = require 'fs'
strHtml   = require '../lib/str-html'

class Registration

  constructor: (args) ->
    # body...

  @readConfig: (request, reply, cb) ->
    @readmeFile ?= 'plugins/requirements.txt'
    fs.readFile @readmeFile , (err, data) ->
      return cb err if err
      @out = strHtml.strToHtml data.toString(0)
      console.log @out
      reply @out


module.exports = Registration
