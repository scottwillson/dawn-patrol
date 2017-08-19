#!/bin/sh
set -e

if grep -q 'auths": {}' ~/.docker/config.json ; then echo run docker login before running this command; fi

(
  cd e2e-test &&
  docker build -t scottwillson/dawn-patrol-e2e-base -f Dockerfile.base . &&
  docker push docker.io/scottwillson/dawn-patrol-e2e-base
)
