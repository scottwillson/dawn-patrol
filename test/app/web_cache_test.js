process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const expect = chai.expect;
chai.use(chaiAsPromised);

const webCache = require('../../src/app/web_cache');

describe('webCache', () => {
  describe('#key', () => {
    it('returns URL with event ID', () => expect(webCache.key(42)).to.equal('/events/42/results.json'));
  });
});
