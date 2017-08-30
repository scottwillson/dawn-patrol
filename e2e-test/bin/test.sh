#!/bin/sh
set -e

docker-compose up --abort-on-container-exit e2e-test
