PORT = 8101


RedisSessions = require "redis-sessions"
rs = new RedisSessions()

express = require 'express'
app = express()

app.use (req, res, next) ->
	res.removeHeader("X-Powered-By")
	next()
	return

app.configure ->
	app.use( express.logger("dev") )
	app.use(express.bodyParser())


app.post '/:app/:id', (req, res) ->
	res.header('Content-Type', "application/json")
	rs.create {app: req.params.app, id: req.params.id, ttl: req.param('ttl'), ip: req.param('ip')}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return

app.get '/:app/:token', (req, res) ->
	res.header('Content-Type', "application/json")
	rs.get {app: req.params.app, token: req.params.token}, (err, resp) ->
		if err
			res.send(err, 500)
			return
		res.send(resp)
		return








































app.listen(PORT)

