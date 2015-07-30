'use strict';

exports.up = function(db, callback) {
  db.createTable('results', {
    id: { type: 'int', primaryKey: true, autoIncrement: true },
    'event_id': { type: 'int', notNull: true }
  }, callback);
};

exports.down = function(db, callback) {
  db.dropTable('results', callback);
};
