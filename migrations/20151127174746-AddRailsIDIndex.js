'use strict';

exports.up = function(db, callback) {
  db.addIndex('results', 'results_rails_id', ['rails_id'], true, callback());
};

exports.down = function(db, callback) {
  db.removeIndex('results_rails_id', callback());
};
