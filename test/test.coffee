_ = require "underscore"
should = require "should"
async = require "async"
app = require "../app"
http = require "../test/support/http"

#
describe 'REST-Sessions Test', ->

	before (done) ->
		http.createServer(app,done)
		return

	after (done) ->
		done()		
		return

	token1 = null
	token2 = null
	user1 = null
	user2 = null

	it 'POST /TestApp/create/user1 should return 200 and a token', (done) ->
		http.request().post('/TestApp/create/user1?ip=127.0.0.1').end (resp) ->
			resp.statusCode.should.equal(200)
			body = JSON.parse(resp.body)
			token1 = body.token
			token1.length.should.equal(64)
			done()
			return
		return
	
	it 'GET /TestApp/get/{token} should return 200 and user1', (done) ->
		http.request().get('/TestApp/get/' + token1).end (resp) ->
			resp.statusCode.should.equal(200)
			body = JSON.parse(resp.body)
			body.id.should.equal('user1')
			user1 = body
			done()
			return
		return

	it 'GET /TestApp/activity should return 200', (done) ->
		http.request().get('/TestApp/activity?dt=600').end (resp) ->
			resp.statusCode.should.equal(200)
			body = JSON.parse(resp.body)
			body.activity.should.equal(1)
			done()
			return
		return

	it 'POST /TestApp/set/{token} set some data', (done) ->
		http.request().post('/TestApp/set/' + token1)
			.set('Content-Type','application/json')
			.write(JSON.stringify({ somebool: true, account: 120.55, name:"Peter Smith" }))
			.end (resp) ->
				resp.statusCode.should.equal(200)
				body = JSON.parse(resp.body)
				body.id.should.equal('user1')
				body.d.somebool.should.equal(true)
				body.d.account.should.equal(120.55)
				body.d.name.should.equal("Peter Smith")
				done()
			return
		return


	it 'DELETE /TestApp/killall should return 200 ', (done) ->
		http.request().delete('/TestApp/killall').expect(200,done)
		return
	




	return