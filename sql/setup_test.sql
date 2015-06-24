drop database if exists "dawn-patrol-test";
drop role if exists "dawn-patrol-test";

create role "dawn-patrol-test" login password 'dawn-patrol-test';
create database "dawn-patrol-test" owner "dawn-patrol-test";

\c "dawn-patrol-test"
set role "dawn-patrol-test";

create table results (
  event_id int not null default null,
  id int not null default null,
  primary key(id)
);

-- How about an index?
