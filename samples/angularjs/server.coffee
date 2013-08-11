require 'coffee-script'

express = require 'express'
routes = require './routes'
http = require 'http'
path = require 'path'

ExpressHTMLSnapshots = require '../../'

app = express()
expressServer = http.createServer app

app.configure () ->
    expressHTMLSnapshots = new ExpressHTMLSnapshots()

    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use expressHTMLSnapshots.middleware
    app.use app.router
    app.use express.static(path.join(__dirname, 'public'))

app.get '/', routes.index

module.exports.start = (callback) ->
    expressServer.listen app.get('port'), () ->
        callback()

module.exports.close = (callback) ->
    expressServer.close callback
