// Generated by CoffeeScript 1.6.3
(function() {
  var app, config, server;

  config = require("./config.json");

  app = require("./app");

  server = app.listen(config.port);

  console.log("Listening on port " + config.port);

}).call(this);
