exports.up = (db, callback) => {
  db.addIndex('results', 'results_event_id', ['event_id'], false, callback());
  db.addIndex('results', 'results_rails_id', ['rails_id'], true, callback());
};

exports.down = (db, callback) => {
  db.removeIndex('results_event_id', callback());
  db.removeIndex('results_rails_id', callback());
};
