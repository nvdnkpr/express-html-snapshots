describe 'Search Engine Detector', () ->
    
    SearchEngineDetector =  require '../../src/search-engine-detector'
    searchEngineDetector = null
    
    beforeEach () ->
        searchEngineDetector = new SearchEngineDetector()

    describe 'isGoogleBot', () ->
        
        it 'should detect Google Bot', () ->
            expect(searchEngineDetector.isGoogleBot 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)').toBeTruthy()
            expect(searchEngineDetector.isGoogleBot 'GoogleBot').toBeTruthy()
            expect(searchEngineDetector.isGoogleBot 'googlebot').toBeTruthy()
            expect(searchEngineDetector.isGoogleBot 'GOOGLEBOT').toBeTruthy()

            expect(searchEngineDetector.isGoogleBot 'Mozilla/5.0 (Yahoo-MMCrawler/4.0; mailto:vertical-crawl-support@yahoo-inc.com)').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'Yahoo').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'yahoo').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'YAHOO').toBeFalsy()

            expect(searchEngineDetector.isGoogleBot 'BingBot').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'bingbot').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'BINGBOT').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)').toBeFalsy()

            expect(searchEngineDetector.isGoogleBot 'mozilla').toBeFalsy()
            expect(searchEngineDetector.isGoogleBot 'webkit').toBeFalsy()

    describe 'isBingBot', () ->
        
        it 'should detect Bing Bot', () ->
            expect(searchEngineDetector.isBingBot 'BingBot').toBeTruthy()
            expect(searchEngineDetector.isBingBot 'bingbot').toBeTruthy()
            expect(searchEngineDetector.isBingBot 'BINGBOT').toBeTruthy()
            expect(searchEngineDetector.isBingBot 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)').toBeTruthy()

            expect(searchEngineDetector.isBingBot 'Mozilla/5.0 (Yahoo-MMCrawler/4.0; mailto:vertical-crawl-support@yahoo-inc.com)').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'Yahoo').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'yahoo').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'YAHOO').toBeFalsy()

            expect(searchEngineDetector.isBingBot 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'GoogleBot').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'googlebot').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'GOOGLEBOT').toBeFalsy()

            expect(searchEngineDetector.isBingBot 'mozilla').toBeFalsy()
            expect(searchEngineDetector.isBingBot 'webkit').toBeFalsy()
            
    describe 'isYahooBot', () ->

        it 'should detect Yahoo Bot', () ->
            expect(searchEngineDetector.isYahooBot 'Mozilla/5.0 (Yahoo-MMCrawler/4.0; mailto:vertical-crawl-support@yahoo-inc.com)').toBeTruthy()
            expect(searchEngineDetector.isYahooBot 'Yahoo').toBeTruthy()
            expect(searchEngineDetector.isYahooBot 'yahoo').toBeTruthy()
            expect(searchEngineDetector.isYahooBot 'YAHOO').toBeTruthy()

            expect(searchEngineDetector.isYahooBot 'BingBot').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'bingbot').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'BINGBOT').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)').toBeFalsy()

            expect(searchEngineDetector.isYahooBot 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'GoogleBot').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'googlebot').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'GOOGLEBOT').toBeFalsy()

            expect(searchEngineDetector.isYahooBot 'mozilla').toBeFalsy()
            expect(searchEngineDetector.isYahooBot 'webkit').toBeFalsy()

    describe 'isSearchEngineBot', () ->

        it 'should detect search engines', () ->
            expect(searchEngineDetector.isSearchEngineBot 'Mozilla/5.0 (compatible; Googlebot/2.1; +http://www.google.com/bot.html)').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'GoogleBot').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'googlebot').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'GOOGLEBOT').toBeTruthy()

            expect(searchEngineDetector.isSearchEngineBot 'BingBot').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'bingbot').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'BINGBOT').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'Mozilla/5.0 (compatible; bingbot/2.0; +http://www.bing.com/bingbot.htm)').toBeTruthy()

            expect(searchEngineDetector.isSearchEngineBot 'Mozilla/5.0 (Yahoo-MMCrawler/4.0; mailto:vertical-crawl-support@yahoo-inc.com)').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'Yahoo').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'yahoo').toBeTruthy()
            expect(searchEngineDetector.isSearchEngineBot 'YAHOO').toBeTruthy()

            expect(searchEngineDetector.isSearchEngineBot 'mozilla').toBeFalsy()
            expect(searchEngineDetector.isSearchEngineBot 'webkit').toBeFalsy()
