drop database if exists dawn_patrol_test;
drop role if exists dawn_patrol_test;

create role dawn_patrol_test login password 'dawn_patrol_test';
create database dawn_patrol_test owner dawn_patrol_test;

\c dawn_patrol_test
set role dawn_patrol_test;

create table results (
  event_id int not null default null,
  id int not null default null,
  primary key(id)
);

-- How about an index?
