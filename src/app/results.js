const config = require('config');
const Promise = require('bluebird');
const pgpLib = require('pg-promise');
const pgp = pgpLib({ promiseLib: Promise });
const db = pgp(config.get('database.connection'));
const railsServer = require('./rails_server');

const resultColumns = [
  'category_id',
  'event_id',
  'person_id',
  'rails_id',
];

const valueArguments = resultColumns.map((_, index) => `$${index + 1}`);

exports.byEventId = (eventId) => {
  return db.manyOrNone('select * from results where event_id=$1', [eventId])
    .then(results => {
      if (results.length) return results;

      return railsServer.byEventId(eventId)
        .then(response => this.insertResults(response));
    })
    .catch(e => console.error(e + ' getting results for event ID ' + eventId));
};

exports.count = () => db
  .one('select count(*) from results')
  .then(data => Number(data.count));

exports.deleteAll = () => db.none('delete from results');

exports.resultValues = result => {
  return resultColumns.map(c => {
    if (c === 'rails_id') {
      return result.id;
    }
    if (result.hasOwnProperty(c)) {
      return result[c];
    }
    return null;
  });
};

exports.insertResults = results => {
  return Promise.each(results, result => {
    return db.none(
      `insert into results (${resultColumns}) values (${valueArguments})`,
      this.resultValues(result)
    )
    .catch(error => {
      // duplicate key (make a method for this)
      if (error.code !== '23505') {
        throw error;
      }
    });
  });
};
