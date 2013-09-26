var Browser, browser, htmlSnapshot, index, middleware;

module.exports = index = {
  Middleware: require('./middleware'),
  EscapedFragmentUtilities: require('./escaped-fragment-utilities'),
  HtmlSnapshot: require('./html-snapshot'),
  SearchEngineDetector: require('./search-engine-detector')
};

Browser = require('zombie');

browser = new Browser();

browser.runScripts = true;

htmlSnapshot = new index.HtmlSnapshot(browser);

middleware = new index.Middleware(htmlSnapshot, new index.SearchEngineDetector(), new index.EscapedFragmentUtilities());

index.middleware = middleware.execute;
