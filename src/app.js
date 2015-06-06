'use strict';

var express = require('express');
var app = express();

app.get('/event_results/0.json', function (req, res) {
  res.send('OK');
});

var server = app.listen(3000, function () {
  var host = server.address().address;
  var port = server.address().port;
  console.log(host);
  console.log(`Dawn Patrol Results app listening at http://${host}:${port}`);
});
