{
  "apps": [
    {
      "name"        : "app",
      "script"      : "dist/server.js",
      "cwd"         : "/var/www/dawn-patrol",
      "instances"   : 0,
      "exec_mode"   : "cluster_mode",
      "env": {
        "NODE_CONFIG": { "echoServer": { "webServerLogFilePath": "/home/dawn-patrol/.pm2/logs/mock-rails-api-server-out-2.log" } }
      },
    },
    {
      "name"        : "echo_server",
      "script"      : "dist/echo_server.js",
      "cwd"         : "/var/www/dawn-patrol",
      "instances"   : 1,
      "exec_mode"   : "cluster_mode"
    },
    {
      "name"        : "mock_rails_api_server",
      "script"      : "dist/mock_rails_api_server.js",
      "cwd"         : "/var/www/dawn-patrol",
      "instances"   : 1,
      "exec_mode"   : "cluster_mode"
    }
  ]
}
