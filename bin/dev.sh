#!/bin/bash
set -e

docker-compose -f docker-compose-dev.yml up --build -d --remove-orphans
exec docker-compose -f docker-compose-dev.yml logs -f --tail=0
