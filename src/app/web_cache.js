const config = require('config');
const Memcached = require('memcached-promisify');

function mockMemcached() {
  return {
    set: () => new Promise(() => true),
  };
}

function cacheClient() {
  if (this.cacheClient) {
    return this.cacheClient;
  }

  if (process.env.NODE_ENV === 'test') {
    this.cacheClient = mockMemcached();
  } else {
    this.cacheClient = new Memcached({'cacheHost': config.get('memcachedHost')});
  }
  return this.cacheClient;
}

exports.key = eventId => `/events/${eventId}/results.json`;

exports.cache = (eventId, response) => {
  return cacheClient().set(this.key(eventId), JSON.stringify(response), 600);
};

// Only used by tests for now
exports.del = (eventId) => cacheClient().del(this.key(eventId));
exports.get = (eventId) => cacheClient().get(this.key(eventId));
