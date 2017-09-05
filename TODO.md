* Ensure MySQL is using UTC
* https://prometheus.io/ for monitoring
* DRY up mock New Relic
* Use New Relic segments for HTTP handlers?
* Semaphore: change to `exec ci`?
* Error aggregation service
  * https://elithrar.github.io/article/http-handler-error-handling-revisited/
  * nginx errors?
* alerts
  * https://github.com/prometheus/alertmanager
  * Prometheus?
  * New Relic
  * Digital Ocean?
  * Docker Hub?
  * Ansible setup?
* https
* Persist data
* migrations
* Backups
* Extract scripts from bin/setup
  * e2e
  * tests
  * start servers
* Move goose code to /db?
* Consolidate DB init
* Ansible server setup?
  * Replace Docker Hub
* Replication from Rails
* read https://peter.bourgon.org/go-best-practices-2016/#dependency-management
* move DB data out of init dir
* Document SemaphoreCI and Docker.io/hub setup
* Review and apply Docker best practices
* Add test of dev build to CI
* CI build should just execute a script
* Deploy deploy containers to stage and prod based on branch
  * Docker image tags
  * branches
  * Separate CI builds
* Canary test before making new container live?
* New Relic RUM or similar?
* think about flags/env/12-factors for config
  * Make API port configurable
* consider https://getgb.io/
* use scratch for go: https://medium.com/@kelseyhightower/optimizing-docker-images-for-static-binaries-b5696e26eb07
* Split into separate projects for independent deploys
  * What does testing/build pipeline look like?
* openDB loop should raise original errors
* Split out mock
* Split out RailsService into CopyService? How to organize services and services DI?
* Ensure implements gorm.Model
* Set up DNS and a floating IP
* Notify on build, deploy
* Can EventService.APIEventService be a pointer?
* Failing E2E test should exit bin/setup
* Check for dupe code
* https://github.com/alecthomas/gometalinter
* Use struct literal initialization for config/args
* Avoid nil checks via default no-op implementations
* make loggers and http clients dependencies
* base images?
* Consider https://github.com/thockin/go-build-template
* Ensure dev builds on CI to catch problems there
* All seed scripts valid?
* Look at https://github.com/go-kit/kit
* Add logging to db/open.go?
* Default struct Logger to something reasonable
* Use command pattern, not services?
* Move appName() to to-level
* https://github.com/google/cadvisor?
* https://github.com/prometheus/node_exporter?
* alerts
* Performance test
  * real URLs like /person/:id/results
* Add assert equal for Dates
