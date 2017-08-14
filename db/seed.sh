#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 dawnpatrol_development dawnpatrol -f /docker-entrypoint-initdb.d/seed
