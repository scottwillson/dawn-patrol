const config = require('config');
const Memcached = require('memcached-promisify');

function mockMemcached() {
  return {
    get: () => new Promise(resolve => resolve(null)),
    set: () => new Promise(resolve => resolve(true)),
  };
}

function cacheClient() {
  if (this.cacheClient) {
    return this.cacheClient;
  }

  if (process.env.NODE_ENV === 'test') {
    this.cacheClient = mockMemcached();
  } else {
    this.cacheClient = new Memcached({ 'cacheHost': config.get('memcachedHost') });
  }
  return this.cacheClient;
}

exports.cache = (eventId, updatedAt, response) => {
  console.log(`cache ${this.key(eventId, updatedAt)}`);
  return cacheClient().set(this.key(eventId, updatedAt), response, 600);
};
exports.get = (eventId, updatedAt) => {
  console.log(`get ${this.key(eventId, updatedAt)}`);
  return cacheClient().get(this.key(eventId, updatedAt));
};
exports.key = (eventId, updatedAt) => `/events/${eventId}/results.json?updatedAt=${updatedAt.valueOf()}`;

// Only used by tests for now
exports.del = (eventId, updatedAt) => cacheClient().del(this.key(eventId, updatedAt));
