const config = require('config');
const railsAppHost = config.get('integrationTest.railsAppHost');
const request = require('request-promise');

exports.resultsForEvent = eventId => {
  const url = 'http://' + railsAppHost + '/events/' + eventId + '/results.json';
  const options = {
    url: url,
    headers: {'User-Agent': 'dawn-patrol'},
  };

  return request.get(options)
    .then(response => JSON.parse(response))
    .catch(e => {
      console.error(e + ' getting results from ' + url);
      throw e;
    });
};
