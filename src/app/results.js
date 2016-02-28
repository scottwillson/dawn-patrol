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
  'name',
  'place',
  'team_id',
  'updated_at',
];

const valueArguments = resultColumns.map((_, index) => `$${index + 1}`);

// Make response look like it came from master
// ID needs to be master_id, not 'our' ID
function mapToMasterColumns(result) {
  result.id = result.master_id;
  delete result.master_id;
  return result;
}

exports.forEvent = (eventId) => {
  return db.manyOrNone('select * from results where event_id=$1', [eventId])
    .then(results => results.map(r => mapToMasterColumns(r)))
    .then(results => {
      if (results.length) return results;

      return masterServer.resultsForEvent(eventId)
        .then(response => {
          if (response.error === 'not found') return null;
          return this.insertResults(response);
        });
    })
    .catch(e => console.error(`${e} getting results for event ID ${eventId}`));
};

exports.eventUpdatedAt = (eventId) => db
  .one('select max(updated_at) from results where event_id=$1', [eventId])
  .then(data => data.max);

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
