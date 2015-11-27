exports.up = (db, callback) => {
  db.addIndex('results', 'results_rails_id', ['rails_id'], true, callback());
};

exports.down = (db, callback) => {
  db.removeIndex('results_rails_id', callback());
};
