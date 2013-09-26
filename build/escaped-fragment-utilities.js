var EscapedFragmentUtilities,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

EscapedFragmentUtilities = (function() {
  function EscapedFragmentUtilities() {
    this.isEscapedRequest = __bind(this.isEscapedRequest, this);
  }

  EscapedFragmentUtilities.prototype.isEscapedRequest = function(request) {
    return request.query._escaped_fragment_ != null;
  };

  EscapedFragmentUtilities.prototype.unescapeRequest = function(request) {
    var key, url;
    url = "" + request.protocol + "://" + request.headers.host + request.path + "#!" + request.query['_escaped_fragment_'] + "?";
    delete request.query['_escaped_fragment_'];
    for (key in request.query) {
      url += "" + key + "=" + request.query[key] + "&";
    }
    url = url.replace(/&$/g, '');
    return url;
  };

  return EscapedFragmentUtilities;

})();

module.exports = EscapedFragmentUtilities;
