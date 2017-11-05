delete from events;
delete from associations;

insert into associations (id, acronym, host, name) values (
  1,
  'CBRA',
  '0.0.0.0|localhost|cbra.local',
  'Cascadia Bicycle Racing Association'
);

insert into events (association_id, name, starts_at) values (1, 'Hellyer Challenge', '2016-12-31 00:00:00 -8:00');
insert into events (association_id, name, starts_at) values (1, 'Aplenrose Velodrome Challenge', '2017-01-09 00:00:00 -8:00');
insert into events (association_id, name, starts_at) values (1, 'Copperopolis Road Race', '2017-07-25 00:00:00 -8:00');
insert into events (association_id, name, starts_at) values (1, 'Tour of the Gila', '2018-01-01 00:00:00 -8:00');
