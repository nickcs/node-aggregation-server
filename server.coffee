app = require './index'
config = require 'config'

server = app.listen process.env.PORT || config.port, ->

  host = server.address().address
  port = server.address().port

  console.log 'Example app listening at http://%s:%s', host, port
