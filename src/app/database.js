const config = require('config');
const Promise = require('bluebird');
const pgpLib = require('pg-promise');
const pgp = pgpLib({ promiseLib: Promise });
const db = pgp(config.get('database.connection'));

exports.count = () => {
  return db
    .one('select count(*) from results')
    .then(data => Number(data.count));
};

exports.deleteAll = () => db.none('delete from results');
