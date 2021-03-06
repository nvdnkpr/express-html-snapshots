var SearchEngineDetector,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

SearchEngineDetector = (function() {
  function SearchEngineDetector() {
    this.isYahooBot = __bind(this.isYahooBot, this);
    this.isBingBot = __bind(this.isBingBot, this);
    this.isGoogleBot = __bind(this.isGoogleBot, this);
    this.isSearchEngineBot = __bind(this.isSearchEngineBot, this);
  }

  SearchEngineDetector.prototype.isSearchEngineBot = function(userAgent) {
    return this.isGoogleBot(userAgent) || this.isBingBot(userAgent) || this.isYahooBot(userAgent);
  };

  SearchEngineDetector.prototype.isGoogleBot = function(userAgent) {
    return /googlebot/i.test(userAgent);
  };

  SearchEngineDetector.prototype.isBingBot = function(userAgent) {
    return /bingbot/i.test(userAgent);
  };

  SearchEngineDetector.prototype.isYahooBot = function(userAgent) {
    return /yahoo/i.test(userAgent);
  };

  return SearchEngineDetector;

})();

module.exports = SearchEngineDetector;
