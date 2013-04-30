###
Rest Sessions

The MIT License (MIT)

Copyright © 2013 Patrick Liess, http://www.tcs.de

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###


RedisSessions = require "redis-sessions"
rs = new RedisSessions()

express = require 'express'
app = express()


app.use (req, res, next) ->
	res.header('Content-Type', "application/json")
	res.removeHeader("X-Powered-By")
	next()
	return

app.configure ->
	app.use( express.logger("dev") )
	app.use(express.bodyParser())


# acitivity(app, dt)

app.get '/:app/activity', (req, res) ->
	rs.activity {app: req.params.app, dt: req.param("dt")}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return
	return

app.post '/:app/create/:id', (req, res) ->
	rs.create {app: req.params.app, id: req.params.id, ttl: req.param('ttl'), ip: req.param('ip')}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return
	return

app.get '/:app/get/:token', (req, res) ->
	rs.get {app: req.params.app, token: req.params.token}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return
	return

app.delete '/:app/killall', (req, res) ->
	rs.killall {app: req.params.app}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return

app.delete '/:app/kill/:token', (req, res) ->
	rs.kill {app: req.params.app, token: req.params.token}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return

app.post '/:app/set/:token', (req, res) ->
	rs.set {app: req.params.app, token: req.params.token, d: req.body}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return
	return

	return




module.exports = app
