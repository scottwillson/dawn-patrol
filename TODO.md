* Refactor openURL to open("{dawnpatrol,rails}") and read URL by convention?
* Use a better testing framework
* Check coverage and add tests for public functions
* Vendor Go deps? Glide? https://github.com/golang/dep
* base images?
* Use overrides with docker-compose files?
* Use overrides/DRY up Dockerfiles?
* Generally use conventions more/fewer flags
* Fix web README
* Persist data
* migrations
* Extract scripts from bin/setup
  * e2e
  * tests
  * start servers
* Create MySQL container
* Add data import to E2E
* Move goose code to /db?
* Consolidate DB init
* Replication
* Backups
* Nagios alerts
* Ansible server setup?
* move DB data out of init dir
* Document SemaphoreCI and Docker.io/hub setup
* Review and apply Docker best practices
* Performance test
* Add test of dev build to CI
* Deploy deploy containers to stage and prod based on branch
  * Docker image tags
  * branches
  * Separate CI builds
* Canary test before making new container live?
* Make API port configurable
* Secrets?
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
