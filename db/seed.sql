delete from events;
delete from associations;

insert into associations (id, acronym, host, name) values (
  0,
  'CBRA',
  '0.0.0.0|localhost|cbra.local',
  'Cascadia Bicycle Racing Association'
);

insert into events (association_id, name, starts_at) values (0, 'Hellyer Challenge', '2016-12-31 00:00:00 -8:00');
insert into events (association_id, name, starts_at) values (0, 'Aplenrose Velodrome Challenge', '2017-01-09 00:00:00 -8:00');
insert into events (association_id, name, starts_at) values (0, 'Copperopolis Road Race', '2017-07-25 00:00:00 -8:00');
insert into events (association_id, name, starts_at) values (0, 'Tour of the Gila', '2018-01-01 00:00:00 -8:00');
