const config = require('config');

const pgpLib = require('pg-promise');
const pgp = pgpLib({ promiseLib: require('bluebird') });
const db = pgp(config.get('database.connection'));

const results = require('../../src/app/results.js');

exports.byMasterID = (masterId) => {
  return db.oneOrNone('select * from results where master_id=$1', [masterId])
  .then(result => {
    if (result) {
      return result;
    }
    return [];
  });
};

exports.count = () => results.count();

exports.countByEvent = (eventId) => {
  return db.one('select count(*) from results where event_id=$1', [eventId])
    .then(result => Number(result.count));
};

exports.insert = (masterId, updatedAt) => {
  const _updatedAt = updatedAt || 'Fri, 17 Nov 1995 10:24:00 UTC';
  return db.none(
    'insert into results (event_id, master_id, updated_at) values ($1, $2, $3)',
    [0, masterId ? masterId : 0, new Date(_updatedAt)]
  );
};
