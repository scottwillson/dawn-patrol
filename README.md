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
    mocha test/app_test.js
    mocha test/echo_server_test.js

    mocha -w test/app_test.js src/echo_server_test.js

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


End to end test
---------------
Development:

    node src/server.js
    node src/mock_rails_api_server.js > tmp/nginx.log
    node src/echo_server.js
    node test/end_to_end_test.js

Vagrant:

    vagrant up
    ./bin/deploy vagrant
    NODE_CONFIG='{"endToEndTest": {"appHost": "0.0.0.0:3001", "railsAppHost": "0.0.0.0:4001"}}' mocha test/end_to_end_test.js

Staging:

    ./bin/provision staging
    ./bin/deploy staging
    NODE_CONFIG='{"endToEndTest": {"appHost": "dawnpatrol.staging.rocketsurgeryllc.com", "railsAppHost": "staging.obra.org"}}' mocha test/end_to_end_test.js

Performance Test
----------------

    loadtest.js -c 8 -n 1000 http://dawnpatrol.staging.rocketsurgeryllc.com/events/0/results.json

Roadmap
-------
*   "extends": "airbnb" ?
* Don't repeat attribute lists
* Really need promises?
* Decompose app and unit test
* Assert end-to-end test response more thoroughly
* Test response body more thoroughly
* Store data in Postgres denormalized (should be able to fulfill any request by 1-2 selects)
* Fetch data from Postgres
* Drop 'endToEndTest' from config
* de-dupe DB config (migrations use separate file)
* Add nginx
* Add uniqueness constraints
* check for outstanding DB migrations before running tests
* Add memcached (with memory limit)
* configure nginx to use memcached
* Have node.js update memcached
* Apply https://github.com/airbnb/javascript
* proper response headers for caching
* Store normalized data
* All https
* Add ember.js front end for fun
* Use hash-like logging
* Move cache updating to separate service?
* Try other data storage/servers and compare performance
* Multiplex requests from production
* Redirect production requests to here
* Docker?
* Use PM2 'ecosystem'?
* Ensure app server throw exceptions
* Authorization for admin actions would be nice!
* Actually return JSON, not strings
* Separate each service into separate project?
* Move DB creds to more secure spot
* Encapsulate end-to-end test running in a simple script
* staging end to end test needs to fetch real event ID and expect correct count
* Ensure EchoServer event emitters are cleaned up in tests
* Batch inserts from Rails server response
* 'use strict' at build time
* add racing_association_id
* consider timestamp on inserts (do update if newer)
