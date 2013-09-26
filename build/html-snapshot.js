var HtmlSnapshot, validator,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

validator = require('validator');

HtmlSnapshot = (function() {
  function HtmlSnapshot(browser) {
    this.browser = browser;
    this.take = __bind(this.take, this);
  }

  HtmlSnapshot.prototype.take = function(url, callback) {
    var e,
      _this = this;
    try {
      validator.check(url).isUrl();
      return this.browser.visit(url, function(err) {
        return callback(err, _this.browser.html());
      });
    } catch (_error) {
      e = _error;
      return callback(e);
    }
  };

  return HtmlSnapshot;

})();

module.exports = HtmlSnapshot;
