## Start

Install git
git clone

Install Docker

Run `./bin/setup`

## Setup

  * Check for docker-compose and try to install it via Homebrew or apt
  * Clean up previous builds
  * Run unit tests
  * Start auto-reloading dev env
  * Will take many minutes the first time, but should be much quicker once Docker base images are cached

## Dev
`docker-compose logs -f --tail=0`
`docker-compose exec db psql -U dawnpatrol dawnpatrol_development`

### local
For development outside of Docker (for example, if you're using Atom's Go-plus to run tests and show coverage in the editor), set environment variables for DB connections.

```
export DATABASE_URL=postgres://dawnpatrol@0.0.0.0:55432/dawnpatrol_test?sslmode=disable
export RAILS_DATABASE_URL="rails:rails@tcp(0.0.0.0:53306)/rails"
go get -u github.com/golang/dep/cmd/dep
dep ensure
```

## Goal

End-to-end Docker dev, test, deploy pipeline.

Dev requires only Docker, git and bash

Do all the things (E2E tests, deployment images) anywhere

Fast as possible

Simple deploys

## Design choices
* Docker.io
* DigitalOcean
* SemaphoreCI
* Several Dockerfiles and docker-compose.ymls
https://success.docker.com/Architecture/Docker_Reference_Architecture%3A_Development_Pipeline_Best_Practices_Using_Docker_EE

## Deploy
docker login

To instrument with New Relic, set NEW_RELIC_LICENSE_KEY in the environment
Set DAWN_PATROL_ENVIRONMENT for dev, test, stage
identity.pub for transfer
CC_TEST_REPORTER_ID

docker login
docker-cloud stack update -f stackfile.yml --sync dawn-patrol-stage
docker-cloud service set --env NEW_RELIC_LICENSE_KEY="…" --redeploy api
docker-cloud service set --env SENTRY_DSN="…" --redeploy api

Open port 2222 on DO host

CHANGE MASTER TO MASTER_LOG_FILE='binary.000726', MASTER_LOG_POS=1792467, MASTER_HOST='obra.org', MASTER_USER='...', MASTER_PASSWORD='...', MASTER_SSL=1;

## Containers

## Replication
Specific to Racing on Rails.
scp -P 2222 -i ~/.ssh/sw_rsa dbdump.db root@transfer.dawn-patrol-stage.fb90a06c.svc.dockerapp.io:.

## Performance testing

warmup:
`ab -n 100 -c 4 http://web.dawn-patrol-stage.c21e9163.svc.dockerapp.io/`

Minimal benchmark:
`ab -n 100 http://web.dawn-patrol-stage.c21e9163.svc.dockerapp.io/`

Typical:
`ab -n 100 -c 2 http://web.dawn-patrol-stage.c21e9163.svc.dockerapp.io/`

Stress:
`ab -n 4000 -c 20 http://web.dawn-patrol-stage.c21e9163.svc.dockerapp.io/`

## Ad hoc testing
`curl 0.0.0.0:3000`
`curl 0.0.0.0:3000/index.json`
`curl -X POST -d "association=rails" 0.0.0.0:8080/rails/copy`

[![Build Status](https://semaphoreci.com/api/v1/scott-willson/dawn-patrol/branches/master/badge.svg)](https://semaphoreci.com/scott-willson/dawn-patrol)
