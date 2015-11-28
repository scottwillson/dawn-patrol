exports.up = (db, callback) => {
  db.createTable('results', {
    id: { type: 'int', primaryKey: true, autoIncrement: true },
    'category_id': { type: 'int' },
    'event_id': { type: 'int', notNull: true },
    'person_id': { type: 'int' },
    'rails_id': { type: 'int' },
  }, callback);
};

exports.down = (db, callback) => db.dropTable('results', callback)
