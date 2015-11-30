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

exports.insert = (masterId) => {
  if (masterId) {
    return db.none(`insert into results (event_id, master_id) values (0, ${masterId})`);
  }
  return db.none(`insert into results (event_id, master_id) values (0, 0)`);
};
