-- Migration: AddAssociationRailsAtFields
-- Created at: 2017-11-16 13:41:18
-- ====  UP  ====

BEGIN;

alter table associations add column rails_created_at timestamp with time zone;
alter table associations add column rails_updated_at timestamp with time zone;

COMMIT;

-- ==== DOWN ====

BEGIN;

alter table associations drop column rails_created_at;
alter table associations drop column rails_updated_at;

COMMIT;
