grant all on wsba.* to 'wsba'@'%' identified by 'rails';

create database wsba;
use wsba;

source /docker-entrypoint-initdb.d/_schema.sql;

insert into people (id, first_name, last_name, name) values (1, 'Mike', 'Murray', 'Mike Murray');
insert into people (id, first_name, last_name, name) values (2, 'Ian', 'Mensher', 'Ian Mensher');

insert into events (date, discipline, city, id, name, promoter_id, state, type, created_at, updated_at) values (
  '2010-04-12',
  'Road',
  'Tahuya',
  1,
  'Tahuya-Seabeck-Tahuya',
  1,
  'WA',
  'SingleDayEvent',
  '2009-12-23 19:18:17',
  '2009-12-30 00:00:00'
);

insert into events (date, discipline, city, id, name, promoter_id, state, type, created_at, updated_at) values (
  '2011-09-01',
  'Criterium',
  'Seattle',
  2,
  'Boat Street Criterium',
  1,
  'WA',
  'SingleDayEvent',
  '2009-03-08 08:59:59',
  '2009-03-08 08:59:59'
);

insert into racing_associations (name, short_name, created_at, updated_at) values (
  'Washington State Bicycle Racing Association',
  'WSBA',
  '2015-01-01 00:00:00',
  '2015-12-31 23:59:59'  
);

insert into categories (id, friendly_param, name) values (
  1,
  'category_3',
  'Category 3'
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
  '2010-04-12',
  '4/12',
  '2010-04-12',
  'Tahuya-Seabeck-Tahuya',
  1,
  'Ian Mensher',
  '23',
  'Category 3',
  'Category 3',
  false,
  2010
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
  '2011-09-01',
  '9/1',
  '2011-09-01',
  'Boat Street Criterium',
  2,
  'Ian Mensher',
  '212',
  'Category 3',
  'Category 3',
  false,
  2011
);
