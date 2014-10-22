var request = require('request');
var expect = require('chai').expect;

var server = require('../index');

describe('aggregration server', function(){
  describe('when the server is started', function() {

    before(function(){
      this.server = server.start();
    });
    after(function(){
      this.server.close();
    });

    it('should respond with an okay', function(done) {
        request('http://localhost:3000', function (error, response, body) {
          expect(error).to.not.exist;
          done();
        });
    });
  });
});
