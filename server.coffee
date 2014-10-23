app = require './index'
config = require 'config'

server = app.listen process.env.PORT || config.port, ->

  host = server.address().address
  port = server.address().port

  logger.info 'App Started - listening at http://%s:%s', host, port
