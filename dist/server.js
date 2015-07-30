'use strict';

var app = require('./app').app;

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;
  console.log('Dawn Patrol Results app listening at http://' + host + ':' + port + ' in ' + process.env.NODE_ENV);
});