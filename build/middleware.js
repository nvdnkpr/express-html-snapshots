var Middleware,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Middleware = (function() {
  function Middleware(htmlSnapshot, searchEngineDetector, espacedFragmentUtilities) {
    this.htmlSnapshot = htmlSnapshot;
    this.searchEngineDetector = searchEngineDetector;
    this.espacedFragmentUtilities = espacedFragmentUtilities;
    this.execute = __bind(this.execute, this);
  }

  Middleware.prototype.execute = function(req, res, next) {
    var url,
      _this = this;
    if (this.espacedFragmentUtilities.isEscapedRequest(req)) {
      url = this.espacedFragmentUtilities.unescapeRequest(req);
      return this.htmlSnapshot.take(url, function(err, html) {
        if (err) {
          return next();
        } else {
          return res.send(html);
        }
      });
    } else if (this.searchEngineDetector.isSearchEngineBot(req.headers['user-agent'])) {
      url = "" + req.protocol + "://" + req.headers.host + req.originalUrl;
      return this.htmlSnapshot.take(url, function(err, html) {
        if (err) {
          return next();
        } else {
          return res.send(html);
        }
      });
    } else {
      return next();
    }
  };

  return Middleware;

})();

module.exports = Middleware;
