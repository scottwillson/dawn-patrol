insert into people (id, first_name, last_name, name) values (1, "Mike", "Murray", "Mike Murray");
insert into people (id, first_name, last_name, name) values (2, "Jame", "Carney", "Jame Carney");

insert into events (date, discipline, city, id, name, promoter_id, state, type, created_at, updated_at) values (
  '2009-07-03',
  'Track',
  'San Jose',
  1,
  'Hellyer Challenge',
  1,
  'CA',
  'SingleDayEvent',
  '2009-01-07 11:34:00',
  '2009-01-07 11:34:00'
);

insert into racing_associations (name, short_name) values (
  'American Track Racing Association',
  'ATRA'
);

insert into categories (id, name) values (
  1,
  "Pro/1/2"
);

insert into races (id, category_id, event_id) values (
  1,
  1,
  1
);

insert into results (event_id, race_id, person_id, name, place) values (
  1,
  1,
  2,
  "Jame Carney",
  "1"
);
