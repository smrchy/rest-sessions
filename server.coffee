app = require "./app"

PORT = process.env.RS_PORT or 3000

server = app.listen(PORT)
console.log "Listening on port #{PORT}"