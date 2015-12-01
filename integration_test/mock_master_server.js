const app = require('./mock_master_app').app;

const server = app.listen(4000, () => {
  const host = server.address().address;
  const port = server.address().port;
  console.log(`Dawn Patrol mock master server listening at http://${host}:${port}`);
});
