'use strict';

process.env.NODE_ENV = 'test';

var request = require('supertest');
var app = require('./app').app;

describe('GET event results', function(){
  it('responds with json', function(done){
    request(app)
      .get('/events/0/results.json')
      .set('Accept', 'application/json')
      .expect(200, done);
  });
});
