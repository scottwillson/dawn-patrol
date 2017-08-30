#!/bin/bash
set -e

docker-compose -f docker-compose-dev.yml up --build -d --remove-orphans
exec docker-compose logs -f --tail=0
