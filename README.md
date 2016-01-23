dawn-patrol
===========
Spike on fast event results API. Use several caching layers.

Also migrate Racing on Master data to a better, shared-tenancy data model on Postgres.

Status
------
Alpha/half-baked. Pushing to Github now get deployments working early.

Getting started
---------------
install Node.js, npm, memcached
add ./node_modules to $PATH

    npm install
    npm start

Create DBs

    # Ubuntu
    sudo apt-get install postgresql
    sudo -u postgres psql postgres -f sql/setup_development.sql

    # OS X
    brew install postgresql
    psql postgres -f sql/setup_development.sql

    db-migrate up
    npm start

Tests
-----
    npm test

    # Or:
    db-migrate up -e test
    mocha -w

Local virtual test server
-------------------------
Install Vagrant
Install Ansible
Create ansible/vagrant with contents like:

    default ansible_ssh_host=127.0.0.1 ansible_ssh_port=2222

Then:

    vagrant up

Deploy
------
    mkdir ansible/.ssh
    ssh-keygen -f ansible/.ssh/id_rsa

    ./bin/deploy

Update vagrant server
---------------------
Only need to do this for changes in provision.yml

    ./bin/provision

Staging server
--------------
Create ansible/staging inventory file with hostname or IP of staging server

    ./bin/provision staging
    ./bin/deploy staging


Integration test
----------------
Development:

    npm start
    node integration_test/mock_master_server.js > tmp/nginx.log
    node src/echo_server.js
    mocha integration_test/test.js

Vagrant:

    vagrant up
    ./bin/deploy vagrant
    NODE_CONFIG='{"appHost": "0.0.0.0:8001", "masterAppHost": "0.0.0.0:4001", "memcachedHost": "0.0.0.0:11212"}' mocha integration_test/test.js

Staging:

    ./bin/provision staging
    ./bin/deploy staging
    NODE_CONFIG='{"appHost": "dawnpatrol.staging.rocketsurgeryllc.com", "masterAppHost": "staging.obra.org"}' mocha integration_test/test.js

Performance Test
----------------

    loadtest -c 8 -n 1000 http://dawnpatrol.staging.rocketsurgeryllc.com/events/0/results.json

Roadmap
-------
* Rework caching
  * ditch enchanced caching
  * use nginx proxy_cache (with file system)
  * tune nginx proxy cache to cache for 10s, re-use stale content, etc.
  * cache rendered JSON in memcached
    * add test for checking last updated_at
    * use URL + updated_at timestamp key
    * rename webCache?
  * rename cache cache and get methods?
* fix nginx install
  * fix nginx log locations to match Ubuntu
* proper response headers for caching
  * Also in cached nginx responses
* Fix memcached config dupe lines
* Test 404s
  * test what happens with master
  * mock in mock master
  * ensure headers are correct
* Test 500, 503, 302 as well
* All https
* Add URLs like /people/2709/2014.json as those are the ones bots actually hit
  * Change to /people/2709.json?year=2014 ?
  * Need to think about caching
* Add ember.js front end for fun
* Use hash-like logging for all apps
* Try other data storage/servers and compare performance
* Multiplex requests from production
* Add fetched_at timestamp. If fetched_at > 10 minutes, check for newer version
  * Would never check if in memcached
* gzip
* Redirect production requests to here
* Docker?
* Use PM2 'ecosystem'?
* Authorization for admin actions would be nice!
* Store normalized data
* Separate each service into separate project?
* Move DB creds to more secure spot
* Encapsulate integration test running in a simple script
* staging integration test needs to fetch real event ID and expect correct count
* Ensure EchoServer event emitters are cleaned up in tests
* Batch inserts from Master server response
* add racing_association_id
* consider timestamp on inserts (do update if newer)
* Need updated_at and created_at from source and self
* consider updating DB, etc in background, preferably after responding to request
* consider batching duplicate API requests
* Default node env to dev? Seems to be undefined.
* Add to CI
* Echo Master JSON response without parsing and reformatting it?
* Add expired event listener
  1. Direct call from Master (UDP?). Delete expired results.
  2. Use message queue
  3. Mark results as stale (don't delete). Queue update.
  4. Queue expiration check on successful requests? (Would generate many requests.)
  5. Do updates in a separate locking process
  6. Consider probabilistic cache updates
* Need to clear out local vagrant pub key after recreating Vagrant instance
* Ensure cold vagrant start really wokrs
* Create server-specific log file
* Ensure PM2 starts up on restart
* Drop keys with null values in response
* mock server should set content type to json
* integration test requests should ask for JSON
* move mockMemcached
