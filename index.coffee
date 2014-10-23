express = require 'express'
request = require 'request'
_ = require 'lodash'
#http = require 'http'
Step = require 'step'

app = express()


request.getBody = (o, cb) ->
  request o, (err, resp, body) ->
    if err then console.log err 
#    console.log body
    cb err, body
    

@out = ""

app.get '/', (req, res) =>
  self = @
  
  last = Step(
    ->
      group = @group()
      request.getBody { uri: 'https://api.flattr.com/rest/v2'}, group()
      request.getBody { uri: 'https://api.flattr.com/rest/v2'}, group()
  #    request.getBody { uri: 'http://ip.jsontest.com/'}, @parallel
      console.log "first"
      return
    ,
    ( err, streams) ->
      if err then console.log err
      
      console.log streams
      res.format
        json: ->
          res.json streams

  )
  

#class Parser extends stream.transform
#
#  constructor: () ->
#    super
#      objectMode: true
#
#  _transform : (data, encoding,cb) ->
#    @push data
#    done()
#  _flush : () ->
#

module.exports = app
