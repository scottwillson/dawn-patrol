'use strict';

var app = require('./api_app').app;

var server = app.listen(4000, function () {
  var host = server.address().address;
  var port = server.address().port;
  console.log(`Dawn Patrol test api server listening at http://${host}:${port}`);
});
