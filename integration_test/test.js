const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const config = require('config');
const request = require('request-promise');
const retry = require('trytryagain');

chai.use(chaiAsPromised);
const expect = chai.expect;

const webCache = require('../src/app/web_cache');

const appHost = config.get('appHost');
const masterAppHost = config.get('masterAppHost');

function resultsCount() {
  return request.get(`http://${appHost}/results.json`).then(response => {
    return JSON.parse(response).count;
  });
}

function deleteAllResults() {
  return request.del(`http://${appHost}/results.json`);
}

function randomEventId() {
  if (config.has('integrationTest.eventId')) {
    return config.get('integrationTest.eventId');
  }
  return Math.round(Math.random() * 10000);
}

function getResultsJSONFromMaster(eventId) {
  return request.get(`http://${masterAppHost}/events/${eventId}/results.json`);
}

function getResultsJSONFromApp(eventId) {
  return request.get(`http://${appHost}/events/${eventId}/results.json`);
}

function expectMasterToReturnResultsJSON(eventId) {
  return getResultsJSONFromMaster(eventId)
    .then((response) => {
      const json = JSON.parse(response);
      expect(json.length).to.equal(3);
      return expect(json[0]).to.include({
        event_id: eventId,
        id: 119686,
        name: 'Nick Skenzick',
        person_id: 52,
        place: '1',
        team_id: 29,
      });
    });
}

function expectAppToReturnResultsJSON(eventId) {
  return getResultsJSONFromApp(eventId)
    .then((response) => {
      const json = JSON.parse(response);
      expect(json.length).to.equal(3);
      const result = json.find(r => r.id === 119686);
      expect(result).to.not.have.any.keys('master_id');

      return expect(result).to.include({
        event_id: eventId,
        name: 'Nick Skenzick',
        person_id: 52,
        place: '1',
        team_id: 29,
      });
    });
}

function expectResultsCountToEventuallyEqual(count) {
  return retry(() => {
    return expect(resultsCount()).to.eventually.equal(count);
  }, { interval: 400, timeout: 10000 });
}

describe('system', function describeSystem() {
  this.timeout(10000);
  const eventId = randomEventId();

  before(() => webCache.del(eventId).then(() => deleteAllResults()));

  it('should store, forward, and cache master requests', () => {
    return expect(resultsCount()).to.eventually.equal(0)
      .then(() => expect(webCache.get(eventId)).to.eventually.be.undefined)
      .then(() => expectMasterToReturnResultsJSON(eventId))
      .then(() => expectResultsCountToEventuallyEqual(3))
      .then(() => expect(webCache.get(eventId)).to.eventually.not.be.undefined)
      .then(() => expectMasterToReturnResultsJSON(eventId))
      .then(() => expectAppToReturnResultsJSON(eventId));
  });
});
