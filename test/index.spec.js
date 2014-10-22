var request = require('request');
var expect = require('chai').expect;

var app = require('../server');

var port = 3001;

describe('aggregration server', function(){
  describe('when the server is started', function() {

    before(function(done){
      this.server = app.listen(port, done);
    });

    after(function(){
      this.server.close();
    });

    it('should respond with an okay', function(done) {
        request('http://localhost:' + port, function (error, response, body) {
          expect(error).to.not.exist;
          done();
        });
    });
  });
});
