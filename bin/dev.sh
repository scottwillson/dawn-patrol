#!/bin/bash
set -e

docker-compose up --build -d --remove-orphans
exec docker-compose logs -f --tail=0
