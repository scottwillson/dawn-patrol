-- Migration: add-association-host
-- Created at: 2017-11-01 16:20:01
-- ====  UP  ====

BEGIN;

alter table associations add column host text not null;

CREATE UNIQUE INDEX ON associations(host);

COMMIT;

-- ==== DOWN ====

BEGIN;

drop INDEX ON associations(host);
alter table associations drop column host;

COMMIT;
