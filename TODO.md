* Rework caching
  * rename cache cache and get methods?
  * validate that Tue Jun 09 2015 08:24:00 GMT-0700 (PDT) is valid for Last-Modified header
* proper response headers for caching
  * Also in cached nginx responses
* Test 404s
  * test what happens with master
  * mock in mock master
  * ensure headers are correct
* Test 500, 503, 302 as well
* All https
* upgrade vagrant box to 15.10
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
* upgrade to newer nginx and use: use_temp_path=off
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
* gracefully handle master downtime
* ES6 lodash?
