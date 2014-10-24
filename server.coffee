app = require './index'

app.startServer (err, server) ->
  server.log 'info', 'Server running at: ' + server.info.uri
