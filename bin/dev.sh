#!/bin/bash
set -e

docker-compose up --build -d --remove-orphans
docker-compose logs -f --tail=0
