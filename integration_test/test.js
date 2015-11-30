process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const config = require('config');
const request = require('request-promise');
const retry = require('trytryagain');

chai.use(chaiAsPromised);
const expect = chai.expect;

const appHost = config.get('integrationTest.appHost');
const masterAppHost = config.get('integrationTest.masterAppHost');

function resultsCount() {
  return request.get('http://' + appHost + '/results.json').then(response => {
    return JSON.parse(response).count;
  });
}

function deleteAllResults() {
  return request.del('http://' + appHost + '/results.json');
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

function expectResultsCountToEventuallyEqual(count) {
  return retry(() => {
    return expect(resultsCount()).to.eventually.equal(count);
  }, { interval: 400, timeout: 10000 });
}

describe('system', function describeSystem() {
  this.timeout(10000);

  before(() => deleteAllResults());

  it('should store, forward, and cache Master API requests', () => {
    const eventId = randomEventId();
    return expect(resultsCount()).to.eventually.equal(0)
      .then(() => expectMasterToReturnResultsJSON(eventId))
      .then(() => expectResultsCountToEventuallyEqual(3))
      .then(() => expectMasterToReturnResultsJSON(eventId));
  });
});
