process.env.NODE_ENV = 'test';

const chai = require('chai');
const chaiAsPromised = require('chai-as-promised');
const expect = chai.expect;
chai.use(chaiAsPromised);

const db = require('../db');
const results = require('../../src/app/results');
const testResults = require('./results');

describe('results', () => {
  beforeEach('truncate DB', () => db.truncate());

  describe('#count', () => {
    context('no results', () => {
      it('counts results', () =>
        expect(results.count()).to.eventually.eq(0)
      );
    });

    context('single results', () => {
      beforeEach('insert existing result', () => testResults.insert());

      it('counts results', () =>
        expect(results.count()).to.eventually.eq(1)
      );
    });

    context('many results', () => {
      beforeEach('insert existing results', () => {
        return testResults.insert()
          .then(() => testResults.insert(1))
          .then(() => testResults.insert(2));
      });

      it('counts results', () =>
        expect(results.count()).to.eventually.eq(3)
      );
    });
  });

  describe('#deleteAll', () => {
    beforeEach('insert existing result', () => testResults.insert());

    it('deletes all results', () => {
      return expect(results.count()).to.eventually.eq(1)
      .then(results.deleteAll())
      .then(expect(results.count()).to.eventually.eq(0));
    });
  });

  describe('#forResults', () => {
    beforeEach('insert existing result', () => testResults.insert(9));

    it('maps columns', () => {
      return results.forEvent(0)
        .then(eventResults => { expect(eventResults.length).to.equal(1); return eventResults[0]; })
        .then(r => expect(r).to.contain({ id: 9 }))
        .then(r => expect(r).to.not.have.key('master_id'));
    });
  });

  describe('#insertResults', () => {
    it('does not insert duplicates', () => {
      return expect(results.count()).to.eventually.eq(0)
        .then(() => results.insertResults([{ event_id: 0, person_id: 0, id: 0 }]))
        .then(() => expect(results.count()).to.eventually.eq(1))
        .then(() => results.insertResults([{ event_id: 0, person_id: 0, id: 0 }]))
        .then(() => expect(results.count()).to.eventually.eq(1));
    });
  });

  describe('#resultValues', () => {
    it('returns nil for empty results', () => {
      const result = { id: 9 };
      return expect(results.resultValues(result)).to.eql([ null, null, null, 9 ]);
    });
  });
});
