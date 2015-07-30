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
    gulp
    node dist/server.js

Create DBs

    # ubuntu
    sudo apt-get install postgresql
    sudo -u postgres psql postgres -f sql/setup_development.sql

    # OS X
    brew install postgresql
    psql postgres -f sql/setup_development.sql

Start gulp to transpile: ```gulp```

Tests
-----
    node node_modules/db-migrate/bin/db-migrate up -e test
    ./node_modules/mocha/bin/mocha dist/app_test.js
    ./node_modules/mocha/bin/mocha dist/echo_server_test.js

Local virtual test server
-------------------------
Install Vagrant
Install Ansible
Create ansible/vagrant with contents like: default ansible_ssh_host=127.0.0.1 ansible_ssh_port=2222
    vagrant up


End to end test
---------------
start servers
    node dist/end_to_end_test.js

provision and deploy to Vagrant test server
    NODE_CONFIG='{"endToEndTest": {"appHost": "0.0.0.0:3001", "railsAppHost": "0.0.0.0:4001"}}' ./node_modules/mocha/bin/mocha dist/end_to_end_test.js

Deploy
------
    mkdir ansible/.ssh
    ssh-keygen -f ansible/.ssh/id_rsa

    ./bin/deploy

Update vagrant server
---------------------
    ./bin/provision

Staging server
--------------
Create ansible/staging inventory file with hostname or IP of staging server

    ./bin/provision staging
    ./bin/deploy staging

Performance Test
----------------
Ad hoc: ```./node_modules/loadtest/bin/loadtest.js -c 8 -n 1000 http://dawnpatrol.staging.rocketsurgeryllc.com/events/0/results.json```

Roadmap
-------
staging end to end test needs to use real event ID
auto test
echo server needs to parse real event ID from log file
awk '{print $7}' obra.access.log | egrep /events/[0-9]+/results.json
Fetch and forward data from OBRA
Store data in Postgres denormalized (should be able to fulfill any request by reading a single row)
Fetch data from Postgres
Drop 'endToEndTest' from config
de-dupe DB config (migrations use separate file)
Add nginx
check for outstanding DB migrations before running tests
Add memcached (with memory limit)
configure nginx to use memcached
Have node.js update memcached
Apply https://github.com/airbnb/javascript
proper response headers for caching
Store normalized data
All https
Add ember.js front end for fun
Use hash-like logging
Move cache updating to separate service?
Try other data storage/servers and compare performance
Multiplex requests from production
Redirect production requests to here
Docker?
Use PM2 'ecosystem'?
Ensure app server throw exceptions
Authorization for admin actions would be nice!
Actually return JSON, not strings
Separate each service into separate project?
Move DB creds to more secure spot
Encapsulate end-to-end test running in a simple script
