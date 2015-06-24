\c dawn_patrol_test
set role dawn_patrol_test;

create table results (
  event_id int not null default null,
  id int not null default null,
  primary key(id)
);

-- How about an index?
