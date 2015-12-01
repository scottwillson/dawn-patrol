const config = require('config');
const fs = require('fs');
const http = require('http');
const Tail = require('always-tail');

function log(text) {
  if (process.env.NODE_ENV !== 'test') {
    console.log(`[echo] ${text}`);
  }
}

log(`start: ${process.env.NODE_ENV}`);
const appHost = config.get('appHost');
const path = config.get('echoServer.webServerLogFilePath');
const fileSize = fs.statSync(path).size;
const tail = new Tail(path, '\n', { start: fileSize });
log(`tail: ${path}`);

tail.isDawnPatrolRequest = line => {
  return line.indexOf('dawn-patrol') > -1;
};

tail.eventId = line => {
  const matches = /events\/(\d+)\/results.json/g.exec(line);
  if (matches === null) {
    return null;
  }
  return matches[1];
};

tail.echoRequest = eventId => {
  http.get(`http://${appHost}/events/${eventId}/results.json`, res => {
    log(`app: ${res.statusCode}`);
  }).on('error', e => {
    log(`app error: ${e.message}`);
  });
};

tail.on('line', data => {
  log(`url: data`);
  if (!tail.isDawnPatrolRequest(data)) {
    const eventId = tail.eventId(data);
    if (eventId !== null) {
      tail.echoRequest(eventId);
    }
  }
});

tail.on('error', error => {
  log('error: ', error);
});

module.exports.echoServer = tail;
