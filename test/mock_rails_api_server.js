const app = require('./mock_rails_api_app').app;

const server = app.listen(4000, () => {
  const host = server.address().address;
  const port = server.address().port;
  console.log(`Dawn Patrol test api server listening at http://${host}:${port}`);
});
