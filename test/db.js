const config = require('config');
const pgpLib = require('pg-promise');

const pgp = pgpLib({ promiseLib: require('bluebird') });
const db = pgp(config.get('database.connection'));

module.exports.truncate = () => db.none('truncate results');
