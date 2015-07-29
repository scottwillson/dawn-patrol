drop database if exists "dawn-patrol";
drop role if exists "dawn-patrol";

create role "dawn-patrol" login password 'dawn-patrol';
create database "dawn-patrol" owner "dawn-patrol";

\c "dawn-patrol"
set role "dawn-patrol";

create table results (
  event_id int not null default null,
  id serial not null,
  primary key(id)
);

-- How about an index?
