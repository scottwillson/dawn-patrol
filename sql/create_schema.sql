\c dawn-patrol
set role dawn-patrol;

create table results (
  event_id int not null default null,
  id int not null default null,
  primary key(id)
);

-- How about an index?
