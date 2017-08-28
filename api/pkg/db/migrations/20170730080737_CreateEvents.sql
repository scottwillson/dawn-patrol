-- +goose Up
create table events (
    id serial primary key,
    name text
);

-- +goose Down
drop table events;
