-- ====  UP  ====
ALTER TABLE events add column association_id integer not null;
ALTER TABLE events ADD CONSTRAINT events_association_id FOREIGN KEY (association_id) REFERENCES associations (id);

-- ==== DOWN ====
ALTER TABLE events DROP CONSTRAINT events_association_id;
ALTER TABLE events drop column association_id;
