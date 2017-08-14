* Pipeline
  * Add api watcher
  * Add web dev server reload (already there?)
  * autotest API
  * autotest web
  * install git, docker, bash; git clone; setup; project can be outside GOPATH!
  * https://success.docker.com/Architecture/Docker_Reference_Architecture%3A_Development_Pipeline_Best_Practices_Using_Docker_EE
  * Unit test?
    * Go API
    * node.js
    * in build container?
  * Build artifacts with Docker build containers
    * DB? (schema? migrations?)
    * API build container creates Go API binary
    * web build container creates prod bundle of static files
  * Store build artifacts
    * Go API binary
    * web-packed static files
  * Build Docker deploy containers
    * From build artifacts
    * API
    * web
  * E2E test deploy containers
  * Deploy deploy containers to stage and prod?
    * Just prod now by default?
    * Separate stage build?
  * Canary test before making new container live?
  * Make things faster and small
  * Vendor Go deps? Glide? https://github.com/golang/dep
  * base images?
  * Use overrides with docker-compose files?
  * Use overrides/DRY up Dockerfiles?
  * Generally use conventions more/fewer flags
  * Make API port configurable
  * Secrets?
  * Ansible to set up compose servers?

* Fix web README
* Docker Hub builds
  * db
  * api
  * web
* CI
  * unit tests
  * E2E
* Deployment
  * data persistence
  * migrations
* Dev
  * run unit tests in Docker?
  * run E2E tests from Docker?
* Try alpine/scratch images once everything works
* Extract scripts from bin/setup
  * e2e
  * tests
  * start servers
* E2E on Digital Ocean
* Prod on Digital Ocean
* hot reload for go server
* Auto-run all tests
* Create MySQL container
* Add data import to E2E
* Move goose code to /db?
* Consolidate DB init
* Update web/README
* Smarter/better wait on DB start in docker-compose
* Refactor API DB URL
* Don't drop prod DB
* Replication
* Backups
* Nagios alerts
* Ansible server setup
