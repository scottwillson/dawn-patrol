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
    sudo -u postgres psql postgres -f sql/setup_test.sql

Start gulp to transpile: ```gulp```

Tests
-----
    npm start
    npm test

Test server
-----------
Install Vagrant
Install Ansible
Create ansible/local with contents like: default ansible_ssh_host=127.0.0.1 ansible_ssh_port=2222
    vagrant up


End to end test against local server
------------------------------------
    node dist/end_to_end_test.js

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
disable delete in production
Make tests run against staging (need config and deply changes)
improve DB setup in new environment
Modify end to end test to work against test server and staging
  * Assume already deployed? (Move local startup code and make optional?)
  * How to assert results?
  * Parameterize ports, URLs, and file locations
awk '{print $7}' obra.access.log | egrep /events/[0-9]+/results.json
Fetch and forward data from OBRA
Store data in Postgres denormalized (should be able to fulfill any request by reading a single row)
Fetch data from Postgres
Add nginx
Add memcached (with memory limit)
configure nginx to use memcached
Have node.js update memcached
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
auto test
Ensure app server throw exceptions
Authorization for admin actions would be nice!
Actually return JSON, not strings
Add unit tests
Separate configs
Separate each service into separate project?
