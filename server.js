// Generated by CoffeeScript 1.9.3
(function() {
  var PORT, app, config, server;

  config = require("./config.json");

  app = require("./app");

  PORT = process.env.RS_PORT || config.port;

  server = app.listen(PORT);

  console.log("Listening on port " + PORT);

}).call(this);
