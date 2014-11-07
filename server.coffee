config = require "./config.json"

app = require "./app"

server = app.listen(config.port)
console.log "Listening on port #{config.port}"