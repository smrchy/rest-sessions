config = require "./config.json"

app = require "./app"

PORT = process.env.RS_PORT or config.port

server = app.listen(PORT)
console.log "Listening on port #{PORT}"