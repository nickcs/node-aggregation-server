request = require 'request'
expect = require('chai').expect

aggregation = require '../lib/aggregation'

describe 'aggregration lib', ->

  it 'should return a single result with a get request', (done) ->
    aggregation.aggregateRequests [
      endPoint: 'http://postcatcher.in/catchers/544abf8531bc3f0200000e3d/'
      method: 'GET'
    ], (err, results) ->
      expect(results.length).to.equal(1)
      done()

  it 'should return a single result with a post request', (done) ->
    aggregation.aggregateRequests [
      endPoint: 'http://postcatcher.in/catchers/544abf8531bc3f0200000e3d/'
      method: 'POST'
    ], (err, results) ->
      expect(results.length).to.equal(1)
      expect(results[0]).to.equal('Created')
      done()

  it 'should return a single result when posting json', (done) ->
    aggregation.aggregateRequests [
      endPoint: 'http://postcatcher.in/catchers/544abf8531bc3f0200000e3d/'
      method: 'POST'
      contentType: 'application/json'
      requiredParams:
        method: "glossary"
        phrase: "text"
    ], (err, results) ->
      expect(results.length).to.equal(1)
      done()

  it 'should return a single result when posting a form', (done) ->
    aggregation.aggregateRequests [
      endPoint: 'http://ip.jsontest.com/'
      method: 'POST'
      contentType: 'application/x-www-form-urlencoded'
      requiredParams:
        method: "glossary"
        phrase: "text"
    ], (err, results) ->
      expect(results.length).to.equal(1)
      done()
