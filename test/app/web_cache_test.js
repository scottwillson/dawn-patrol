process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const expect = chai.expect;
chai.use(chaiAsPromised);

const webCache = require('../../src/app/web_cache');

describe('webCache', () => {
  describe('#key', () => {
    it('returns URL with event ID', () =>
      expect(webCache.key(42, new Date(2003, 1)))
      .to.equal('/events/42/results.json?updatedAt=1044086400000')
    );
  });
});
