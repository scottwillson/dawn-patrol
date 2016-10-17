insert into people (id, first_name, last_name, name) values (1, "Ryan", "Rickerts", "Ryan Rickerts");
insert into people (id, first_name, last_name, name) values (2, "Martha", "Walsh", "Martha Walsh");

insert into events (date, discipline, city, id, name, promoter_id, state, type, created_at, updated_at) values (
  '2004-05-10',
  'Road',
  'Tahuya',
  1,
  'Tahuya-Seabeck-Tahuya Road Race',
  1,
  'WA',
  'SingleDayEvent',
  '2004-02-07 11:34:00',
  '2004-02-07 11:34:00'
);

insert into events (date, discipline, city, id, name, state, type, created_at, updated_at) values (
  '2004-05-11',
  'Track',
  'Seattle',
  2,
  'Marymoor Omnium',
  'WA',
  'MultiDayEvent',
  '2004-02-07 11:34:00',
  '2004-02-07 11:34:00'
);

insert into events (date, discipline, city, id, name, parent_id, state, type, created_at, updated_at) values (
  '2004-05-11',
  'Track',
  'Seattle',
  3,
  'Day One',
  2,
  'WA',
  'SingleDayEvent',
  '2004-02-07 11:34:00',
  '2004-02-07 11:34:00'
);

insert into editors_events (event_id, editor_id) values (
  1,
  2
);

insert into racing_associations (name, short_name) values (
  'Washington State Bicycling Association',
  'WSBA'
);
