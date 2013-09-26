class SearchEngineDetector
    
    isSearchEngineBot: (userAgent) =>
        return @isGoogleBot(userAgent) or @isBingBot(userAgent) or @isYahooBot(userAgent)

    isGoogleBot: (userAgent) =>
        return /googlebot/i.test(userAgent)

    isBingBot: (userAgent) =>
        return /bingbot/i.test(userAgent)

    isYahooBot: (userAgent) =>
        return /yahoo/i.test(userAgent)

module.exports = SearchEngineDetector
