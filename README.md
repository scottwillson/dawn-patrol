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
