-- Migration: AddCreatedAtAndUpdatedAt
-- Created at: 2017-12-15 13:45:35
-- ====  UP  ====

begin;

alter table associations add column created_at timestamp with time zone;
alter table associations add column updated_at timestamp with time zone;
alter table events add column created_at timestamp with time zone;
alter table events add column updated_at timestamp with time zone;

commit;

-- ==== DOWN ====

begin;

alter table associations drop column created_at;
alter table associations drop column updated_at;
alter table events drop column created_at;
alter table events drop column updated_at;

commit;
