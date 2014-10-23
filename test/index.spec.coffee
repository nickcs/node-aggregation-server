request = require 'request'
expect = require('chai').expect

app = require '../index'

describe 'aggregration server', ->

  describe 'when the server is started', ->

    before (done) ->
      app.startServer (err,server) =>
        @server = server
        done()

    after (done) ->
      @server.stop(done)

    it 'should respond with an okay', (done) ->
        request @server.info.uri, (error, response, body) ->
          expect(response.statusCode).to.equal(200)
          done()

    describe 'requesting requirements', ->

      it 'should respond with a text body', (done) ->
        request @server.info.uri + '/register', (error, response, body) ->
          expect(body).length.gt(100)
          done()
