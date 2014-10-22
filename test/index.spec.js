var request = require('request');
var expect = require('chai').expect;

var app = require('../index');

var freeport = require('freeport');

describe('aggregration server', function(){

  describe('when the server is started', function() {

    before(function(done){
      freeport(function(err,port){
        this.uri = 'http://localhost:' + port;
        this.server = app.listen(port, done);
      }.bind(this));
    });

    after(function(){
      this.server.close();
    });

    it('should respond with an okay', function(done) {
        request(this.uri, function (error, response, body) {
          expect(error).to.not.exist;
          done();
        });
    });
  });
});
