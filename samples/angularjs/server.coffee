require 'coffee-script'

express = require 'express'
http = require 'http'
path = require 'path'

ExpressHTMLSnapshots = require '../../'

app = express()
expressServer = http.createServer app

app.configure () ->
    options =
        prefetchUrls: [
            'http://localhost:3000/#!/home'
        ]
    expressHTMLSnapshots = new ExpressHTMLSnapshots options

    app.set 'port', process.env.PORT || 3000
    app.set 'views', __dirname + '/views'
    app.set 'view engine', 'jade'
    app.use express.favicon()
    app.use express.bodyParser()
    app.use express.methodOverride()
    app.use expressHTMLSnapshots.middleware
    app.use app.router
    app.use express.static(path.join(__dirname, 'public'))

app.get '/', (req, res) ->
    res.render 'index', { title: 'Express' }

module.exports.start = (callback) ->
    expressServer.listen app.get('port'), () ->
        callback()

module.exports.close = (callback) ->
    expressServer.close callback
