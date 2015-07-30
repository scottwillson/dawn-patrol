drop database if exists "dawn-patrol";
drop role if exists "dawn-patrol";

create role "dawn-patrol" login password 'dawn-patrol';
create database "dawn-patrol" owner "dawn-patrol";

drop database if exists "dawn-patrol-test";
drop role if exists "dawn-patrol-test";

create role "dawn-patrol-test" login password 'dawn-patrol-test';
create database "dawn-patrol-test" owner "dawn-patrol-test";
