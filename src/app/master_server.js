const _ = require('lodash');
const config = require('config');
const masterAppHost = config.get('masterAppHost');
const request = require('request-promise');

function parseResponse(response) {
  const json = JSON.parse(response);
  _.forEach(json, (result) => {
    result.updated_at = new Date(result.updated_at);
  });
  return json;
}

exports.resultsForEvent = eventId => {
  const url = `http://${masterAppHost}/events/${eventId}/results.json`;
  const options = {
    url,
    headers: { 'User-Agent': 'dawn-patrol' },
  };

  return request.get(options)
    .then(response => parseResponse(response))
    .catch(e => {
      console.error(`${e} getting results from ${url}`);
      throw e;
    });
};
