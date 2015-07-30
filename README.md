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

Create DBs (Ubuntu)
    sudo apt-get install postgresql
    sudo -u postgres psql postgres -f sql/setup_development.sql

Start gulp to transpile: ```gulp```

Tests
-----
    node node_modules/db-migrate/bin/db-migrate up -e test
    ./node_modules/mocha/bin/mocha dist/app_test.js
    ./node_modules/mocha/bin/mocha dist/echo_server_test.js

Test server
-----------
Install Vagrant
Install Ansible
Create ansible/local with contents like: default ansible_ssh_host=127.0.0.1 ansible_ssh_port=2222
    vagrant up


End to end test
---------------
start servers
    node dist/end_to_end_test.js

provision and deploy to local Vagrant test server
    NODE_CONFIG='{"endToEndTest": {"appHost": "0.0.0.0:3001", "railsAppHost": "0.0.0.0:4001"}}' ./node_modules/mocha/bin/mocha dist/end_to_end_test.js

Deploy
------
    mkdir ansible/.ssh
    ssh-keygen -f ansible/.ssh/id_rsa

    ./bin/deploy

Update test server
------------------
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
improve DB setup in new environment
awk '{print $7}' obra.access.log | egrep /events/[0-9]+/results.json
Fetch and forward data from OBRA
Store data in Postgres denormalized (should be able to fulfill any request by reading a single row)
Fetch data from Postgres
Drop 'endToEndTest' from config
de-dupe DB config
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
Move cache updating to separate service?
Try other data storage/servers and compare performance
Multiplex requests from production
Redirect production requests to here
Rejigger Ansible files to follow best practices and remove duplication
Docker
Use PM2 'ecosystem'
Move pm2_process.js out of git and customize per env?
auto test
Ensure app server throw exceptions
Authorization for admin actions would be nice!
Actually return JSON, not strings
Add unit tests
Separate configs
Separate each service into separate project?
Use hash-like logging
