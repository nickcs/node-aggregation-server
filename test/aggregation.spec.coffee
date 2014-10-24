request = require 'request'
expect = require('chai').expect

aggregation = require '../lib/aggregation'

describe 'aggregration lib', ->

  it 'should return a single result with a get request', (done) ->
    aggregation.aggregateRequests [
      endPoint: "http://ip.jsontest.com/"
      method: "GET"
    ], (err, results) ->
      expect(results.length).to.equal(1)
      done()
