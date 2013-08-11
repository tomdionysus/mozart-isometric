express = require "express"
path = require "path"
fs = require "fs"
connectLivereload = require "connect-livereload"
app = express()

# Grab configuration options.
port = process.env.PORT || 8080;
base = path.resolve('./public')

GLOBAL.app = app

app.configure ->
  app.use express.logger(format: "dev")
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.methodOverride()
  app.use app.router
  app.use connectLivereload({port: 36729})
  app.use express.static(base)
  app.use (req, res) ->
    res.sendfile(base+"/index.html")

app.configure "development", ->
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.methodOverride()
  app.use app.router
  app.use connectLivereload({port: 36729})
  app.use express.static(base)
  app.use (req, res) ->
    res.sendfile(base+"/index.html")

app.use express.errorHandler(
  dumpExceptions: true
  showStack: true
)

app.configure "production", ->
  app.use express.compress()
  app.use express.bodyParser()
  app.use express.cookieParser()
  app.use express.methodOverride()
  app.use app.router
  app.use express.static(base)
  app.use (req, res) ->
    res.sendfile(base+"/index.html")
  app.use express.errorHandler()

app.listen port
console.log "Express server listening on port #{port}"