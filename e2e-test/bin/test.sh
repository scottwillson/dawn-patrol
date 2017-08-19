#!/bin/sh
set -e

docker-compose -f docker-compose-deploy.yml up e2e-test
