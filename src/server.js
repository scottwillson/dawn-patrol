const app = require('./app').app;

const server = app.listen(3000, () => {
  const host = server.address().address;
  const port = server.address().port;
  console.log(`Dawn Patrol Results app listening at http://${host}:${port} in node env '${process.env.NODE_ENV}'`);
});
