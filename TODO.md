* Persist data
* migrations
* https://prometheus.io/ for monitoring
* think about flags/env/12-factors for config
* Extract scripts from bin/setup
  * e2e
  * tests
  * start servers
* Create MySQL container
* consider go-kit/log for structured logging
* Add data import to E2E
* Move goose code to /db?
* Consolidate DB init
* Replication
* Backups
* Nagios alerts
  * Or something more modern
* Ansible server setup?
* Error catching
* Something like New Relic
* read https://peter.bourgon.org/go-best-practices-2016/#dependency-management
* move DB data out of init dir
* Document SemaphoreCI and Docker.io/hub setup
* Review and apply Docker best practices
* Performance test
* Add test of dev build to CI
* CI build should just execute a script
* Deploy deploy containers to stage and prod based on branch
  * Docker image tags
  * branches
  * Separate CI builds
* Canary test before making new container live?
* Make API port configurable
* Secrets?
* consider https://getgb.io/
* use scratch for go: https://medium.com/@kelseyhightower/optimizing-docker-images-for-static-binaries-b5696e26eb07
* Split into separate projects for independent deploys
  * What does testing/build pipeline look like?
* Be consistent with .sh or not
* Ensure reflex really notices changes to all files
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
