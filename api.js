var jsonServer = require('json-server')

// Returns an Express server
var server = jsonServer.create()

// Set default middlewares (logger, static, cors and no-cache)
server.use(jsonServer.defaults())

var router = jsonServer.router('src/Datadump/loksabha.json')
server.use(router)

console.log('Listening at 4000')
server.listen(4000)
