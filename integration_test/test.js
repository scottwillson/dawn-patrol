process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const config = require('config');
const request = require('request-promise');
const retry = require('trytryagain');

chai.use(chaiAsPromised);
const expect = chai.expect;

const appHost = config.get('integrationTest.appHost');
const railsAppHost = config.get('integrationTest.railsAppHost');

function getResultsCount() {
  return request.get('http://' + appHost + '/results.json').then(response => {
    return JSON.parse(response).count;
  });
}

function randomEventId() {
  if (config.has('integrationTest.eventId')) {
    return config.get('integrationTest.eventId');
  }
  return Math.round(Math.random() * 10000);
}

function requestResultsJSON(eventId) {
  return request.get(`http://${railsAppHost}/events/${eventId}/results.json`);
}

describe('system', function describeSystem() {
  this.timeout(10000);

  before(() => {
    return request.del('http://' + appHost + '/results.json');
  });

  it('should store, forward, and cache Rails API requests', () => {
    const eventId = randomEventId();
    return expect(getResultsCount()).to.eventually.equal(0)
      .then(() => {
        return retry(() => {
          return requestResultsJSON(eventId).then(
            (response) => {
              const json = JSON.parse(response);
              expect(json.length).to.equal(3);
              expect(json[0]).to.contain.any.keys('event_id');
              return expect(getResultsCount()).to.eventually.equal(3);
            }
          );
        }, { interval: 100, timeout: 10000 });
      })
      .then(() => {
        return retry(() => {
          return requestResultsJSON(eventId).then(
            response => {
              const json = JSON.parse(response);
              expect(json.length).to.equal(3);
              expect(json[0]).to.contain.any.keys('event_id');
              return expect(getResultsCount()).to.eventually.equal(3);
            }
          );
        }, { interval: 100, timeout: 10000 });
      });
  });
});
