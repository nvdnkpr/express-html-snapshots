require('coffee-script');

var express = require('express')
    , routes = require('./routes')
    , http = require('http')
    , path = require('path');

var expressHTMLSnapshots = require('../../lib/express-html-snapshots');

var app = express();
var expressServer = http.createServer(app);

app.configure(function(){
    app.set('port', process.env.PORT || 3000);
    app.set('views', __dirname + '/views');
    app.set('view engine', 'jade');
    app.use(express.favicon());
    app.use(express.logger('dev'));
    app.use(express.bodyParser());
    app.use(express.methodOverride());
    app.use(expressHTMLSnapshots.middleware);
    app.use(app.router);
    app.use(require('stylus').middleware(__dirname + '/public'));
    app.use(express.static(path.join(__dirname, 'public')));
});

app.configure('development', function(){
    app.use(express.errorHandler());
});

app.get('/', routes.index);

module.exports.start = function(callback){
    expressServer.listen(app.get('port'), function(){
        console.log("Express server listening on port " + app.get('port'));
        callback();
    });
};

module.exports.close = function(callback){
    expressServer.close(callback);
};
