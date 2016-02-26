process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const expect = chai.expect;
chai.use(chaiAsPromised);

const responseCache = require('../../src/app/response_cache');

describe('responseCache', () => {
  describe('#key', () => {
    it('returns URL with event ID', () =>
      expect(responseCache.key(42, new Date(2003, 1)))
      .to.equal('/events/42/results.json?updatedAt=1044086400000')
    );
  });
});
