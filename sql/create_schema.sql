\c dawn-patrol-test
set role dawn-patrol-test;

create table results (
  event_id int not null default null,
  id int not null default null,
  primary key(id)
);

-- How about an index?
