// Generated by CoffeeScript 1.6.2
/*
Rest Sessions

The MIT License (MIT)

Copyright © 2013 Patrick Liess, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/


(function() {
  var RedisSessions, app, express, rs;

  RedisSessions = require("redis-sessions");

  rs = new RedisSessions();

  express = require('express');

  app = express();

  app.use(function(req, res, next) {
    res.header('Content-Type', "application/json");
    res.removeHeader("X-Powered-By");
    next();
  });

  app.configure(function() {
    app.use(express.logger("dev"));
    app.use(express.bodyParser());
  });

  app.get('/:app/activity', function(req, res) {
    rs.activity({
      app: req.params.app,
      dt: req.param("dt")
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app.put('/:app/create/:id', function(req, res) {
    rs.create({
      app: req.params.app,
      id: req.params.id,
      ttl: req.param('ttl'),
      ip: req.param('ip')
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app.get('/:app/get/:token', function(req, res) {
    rs.get({
      app: req.params.app,
      token: req.params.token
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app.post('/:app/set/:token', function(req, res) {
    rs.set({
      app: req.params.app,
      token: req.params.token,
      d: req.body
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app.get('/:app/soid/:id', function(req, res) {
    rs.soid({
      app: req.params.app,
      id: req.params.id
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app["delete"]('/:app/kill/:token', function(req, res) {
    return rs.kill({
      app: req.params.app,
      token: req.params.token
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app["delete"]('/:app/killsoid/:id', function(req, res) {
    return rs.killsoid({
      app: req.params.app,
      id: req.params.id
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  app["delete"]('/:app/killall', function(req, res) {
    rs.killall({
      app: req.params.app
    }, function(err, resp) {
      if (err) {
        res.send(err, 500);
        return;
      }
      res.send(resp);
    });
  });

  module.exports = app;

}).call(this);
