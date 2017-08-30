#!/bin/sh
set -e

docker-compose -f docker-compose-deploy.yml up --abort-on-container-exit e2e-test
