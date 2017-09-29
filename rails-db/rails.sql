insert into people (id, first_name, last_name, name) values (1, 'Mike', 'Murray', 'Mike Murray');
insert into people (id, first_name, last_name, name) values (2, 'Jame', 'Carney', 'Jame Carney');

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

insert into events (date, discipline, city, id, name, promoter_id, state, type, created_at, updated_at) values (
  '2009-07-10',
  'Track',
  'Portland',
  2,
  'AVC',
  1,
  'OR',
  'SingleDayEvent',
  '2009-01-07 11:35:00',
  '2009-01-09 02:00:01'
);

insert into racing_associations (name, short_name) values (
  'American Track Racing Association',
  'ATRA'
);

insert into categories (id, friendly_param, name) values (
  1,
  'pro_1_2',
  'Pro/1/2'
);

insert into races (id, category_id, event_id) values (
  1,
  1,
  1
);

insert into races (id, category_id, event_id) values (
  2,
  1,
  2
);

insert into results (
  event_id,
  race_id,
  person_id,
  competition_result,
  date,
  event_date_range_s,
  event_end_date,
  event_full_name,
  id,
  name,
  place,
  race_full_name,
  race_name,
  team_competition_result,
  year
) values (
  1,
  1,
  2,
  false,
  '2009-07-03',
  '7/29',
  '2009-07-03',
  'Hellyer Challenge',
  1,
  'Jame Carney',
  '1',
  'Pro/1/2',
  'Pro/1/2',
  false,
  2009
);

insert into results (
  event_id,
  race_id,
  person_id,
  competition_result,
  date,
  event_date_range_s,
  event_end_date,
  event_full_name,
  id,
  name,
  place,
  race_full_name,
  race_name,
  team_competition_result,
  year
) values (
  2,
  2,
  2,
  false,
  '2009-07-10',
  '7/10',
  '2009-07-10',
  'AVC',
  2,
  'Jame Carney',
  '9',
  'Pro/1/2',
  'Pro/1/2',
  false,
  2009
);
