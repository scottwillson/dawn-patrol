const config = require('config');
const pgpLib = require('pg-promise');
const Promise = require('bluebird');
const pgp = pgpLib({ promiseLib: Promise });
const db = pgp(config.get('database.connection'));
const masterServer = require('./master_server');

const resultColumns = [
  'category_id',
  'event_id',
  'person_id',
  'master_id',
];

const valueArguments = resultColumns.map((_, index) => `$${index + 1}`);

exports.forEvent = (eventId) => {
  return db.manyOrNone('select * from results where event_id=$1', [eventId])
    .then(results => {
      if (results.length) return results;

      return masterServer.resultsForEvent(eventId)
        .then(response => this.insertResults(response));
    })
    .catch(e => console.error(`${e} getting results for event ID ${eventId}`));
};

exports.count = () => db
  .one('select count(*) from results')
  .then(data => Number(data.count));

exports.deleteAll = () => db.none('delete from results');

exports.resultValues = result => {
  return resultColumns.map(c => {
    if (c === 'master_id') {
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
