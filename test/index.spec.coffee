request = require 'request'
expect = require('chai').expect

app = require '../index'

freeport = require 'freeport'

describe 'aggregration server', ->

  describe 'when the server is started', ->

    before (done) ->
      freeport (err,port) =>
        @uri = 'http://localhost:' + port
        @server = app.listen port, done

    after ->
      @server.close()

    it 'should respond with an okay', (done) ->
        request @uri, (error, response, body) ->
          expect(error).to.not.exist
          done()
