dawn-patrol
===========
Spike on fast event results API. Use several caching layers.

Also migrate Racing on Rails data to a better, shared-tenancy data model on Postgres.

Status
------
Alpha/half-baked. Pushing to Github now get deployments working early.

Getting started
---------------
install Node.js, npm

    npm install
    node src/server.js

Create DBs

    # Ubuntu
    sudo apt-get install postgresql
    sudo -u postgres psql postgres -f sql/setup_development.sql

    # OS X
    brew install postgresql
    psql postgres -f sql/setup_development.sql

    db-migrate up

Add ./node_modules to $PATH

Tests
-----
    db-migrate up -e test
    mocha

    # Or:
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

    node src/server.js
    node integration_test/mock_rails_api_server.js > tmp/nginx.log
    node src/echo_server.js
    mocha integration_test/test.js

Vagrant:

    vagrant up
    ./bin/deploy vagrant
    NODE_CONFIG='{"integrationTest": {"appHost": "0.0.0.0:3001", "railsAppHost": "0.0.0.0:4001"}}' mocha integration_test/test.js

Staging:

    ./bin/provision staging
    ./bin/deploy staging
    NODE_CONFIG='{"integrationTest": {"appHost": "dawnpatrol.staging.rocketsurgeryllc.com", "railsAppHost": "staging.obra.org"}}' mocha integration_test/test.js

Performance Test
----------------

    loadtest.js -c 8 -n 1000 http://dawnpatrol.staging.rocketsurgeryllc.com/events/0/results.json

Roadmap
-------
* Decompose app and unit test
* Split database.js into database.js and results.js
* DRY up test
* byEventId should re-raise exceptions
* Assert integration test response more thoroughly
* Test response body more thoroughly
* Store normalized data
* Store data in Postgres denormalized (should be able to fulfill any request by 1-2 selects)
* Drop 'integrationTest' from config
* de-dupe DB config (migrations use separate file)
* Add nginx
* check for outstanding DB migrations before running tests
* Add memcached (with memory limit)
* configure nginx to use memcached
* Have node.js update memcached
* proper response headers for caching
* All https
* Add ember.js front end for fun
* Use hash-like logging for all apps
* Move cache updating to separate service?
* Try other data storage/servers and compare performance
* Multiplex requests from production
* Redirect production requests to here
* Docker?
* Use PM2 'ecosystem'?
* Authorization for admin actions would be nice!
* Actually return JSON, not strings
* Separate each service into separate project?
* Move DB creds to more secure spot
* Encapsulate integration test running in a simple script
* staging integration test needs to fetch real event ID and expect correct count
* Ensure EchoServer event emitters are cleaned up in tests
* Batch inserts from Rails server response
* add racing_association_id
* consider timestamp on inserts (do update if newer)
* Need updated_at and created_at from source and self
* consider updating DB, etc in background, preferably after responding to request
* consider batching duplicate API requests
* Default node env to dev? Seems to be undefined.
