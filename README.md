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
    node start

Tests
-----
    npm start
    npm test

End to end test against local server
------------------------------------
    END_TO_END_HOST=0.0.0.0:3001 npm test

Test server
-----------
Install Vagrant
Install Ansible

    vagrant up

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

Roadmap
-------
ES6
Deploy branches
Add basic monitoring
Collect metrics
node.js app with canned response
Add performance test
Fetch and forward data from OBRA
Store data in Postgres denormalized (should be able to fufill any request by reading a single row)
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
Docker
PM2 without global?
