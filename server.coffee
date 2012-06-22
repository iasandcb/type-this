express = require("express")
RedisStore = require("connect-redis")(express)
app = module.exports = express.createServer()
MemStore = express.session.MemoryStore

require "coffee-script"
app.configure ->
  app.set "views", __dirname + "/views"
  app.set "view engine", "coffee"
  app.register '.coffee', require('coffeekup').adapters.express
  app.use express.bodyParser()
  app.use express.methodOverride()
  app.use express.cookieParser()
  app.use express.session
    secret: "bdfajfkasjdfkjalkfjsakljdfkasj"
    store: MemStore
      reapInterval: 60000 * 10

  app.use app.router
  app.use express.static(__dirname + "/public")

app.configure "development", ->
  app.use express.errorHandler(
    dumpExceptions: true
    showStack: true
  )

app.configure "production", ->
  app.use express.errorHandler()

require("./routes/index") app
# require("./routes/game") app
app.listen 3000, ->
  console.log "Express server listening on port %d in %s mode", app.address().port, app.settings.env