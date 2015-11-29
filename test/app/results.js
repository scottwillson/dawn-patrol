const config = require('config');

const pgpLib = require('pg-promise');
const pgp = pgpLib({ promiseLib: require('bluebird') });
const db = pgp(config.get('database.connection'));

const results = require('../../src/app/results.js');

exports.byRailsID = (railsId) => {
  return db.oneOrNone('select * from results where rails_id=$1', [railsId])
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

exports.insert = (railsId) => {
  if (railsId) {
    return db.none(`insert into results (event_id, rails_id) values (0, ${railsId})`);
  }
  return db.none(`insert into results (event_id, rails_id) values (0, 0)`);
};
