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
