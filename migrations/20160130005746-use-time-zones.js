exports.up = (db, callback) => {
  db.runSql('alter table results alter column created_at type timestamp with time zone', callback);
  db.runSql('alter table results alter column updated_at type timestamp with time zone', callback);
};
