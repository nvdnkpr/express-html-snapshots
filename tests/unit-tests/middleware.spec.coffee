describe 'middleware', () ->
    
    Middleware = require '../../src/middleware'
    middleware = null
    next = null
    
    beforeEach () ->
        next = jasmine.createSpy 'next'

    it 'should call res.send with snapshotted html if a search engine user-agent is detected', () ->
        #Arrange
        fakeHtml = '<html><head></head><body>Hello</body></html>'
        fakeHtmlSnapshot =
            take: {}
        spyOn(fakeHtmlSnapshot, 'take').andCallFake (url, callback) ->
            callback null, fakeHtml

        fakeSearchEngineDetector =
            isSearchEngineBot: {}
        spyOn(fakeSearchEngineDetector, 'isSearchEngineBot').andReturn true

        fakeEscapeFragmentUtilities =
            isEscapedRequest: {}
        spyOn(fakeEscapeFragmentUtilities, 'isEscapedRequest').andReturn false
        
        fakeRequest =
            protocol: 'http'
            originalUrl: '/search?q=openify.it'
            headers:
                host: 'localhost'
                'user-agent': 'googlebot'
        
        fakeResponse =
            send: jasmine.createSpy 'res.send'

        middleware = new Middleware fakeHtmlSnapshot, fakeSearchEngineDetector, fakeEscapeFragmentUtilities

        #Act
        middleware.execute fakeRequest, fakeResponse, next

        #Assert
        expect(next).not.toHaveBeenCalled()
        expect(fakeHtmlSnapshot.take).toHaveBeenCalledWith 'http://localhost/search?q=openify.it', jasmine.any(Function)
        expect(fakeResponse.send).toHaveBeenCalledWith fakeHtml

    it 'should call res.send with snapshotted html if _escaped_fragment_ is detected', () ->
        #Arrange
        fakeHtml = '<html><head></head><body>Hello</body></html>'
        fakeHtmlSnapshot =
            take: {}
        spyOn(fakeHtmlSnapshot, 'take').andCallFake (url, callback) ->
            callback null, fakeHtml

        fakeSearchEngineDetector =
            isSearchEngineBot: {}
        spyOn(fakeSearchEngineDetector, 'isSearchEngineBot').andReturn false

        fakeEscapeFragmentUtilities =
            isEscapedRequest: {}
            unescapeRequest: {}
        fakeUrl = 'http://localhost/#!/Home'
        spyOn(fakeEscapeFragmentUtilities, 'isEscapedRequest').andReturn true
        spyOn(fakeEscapeFragmentUtilities, 'unescapeRequest').andReturn fakeUrl
        
        fakeRequest =
            headers:
                'user-agent': 'webkit'
        
        fakeResponse =
            send: jasmine.createSpy 'res.send'

        middleware = new Middleware fakeHtmlSnapshot, fakeSearchEngineDetector, fakeEscapeFragmentUtilities

        #Act
        middleware.execute fakeRequest, fakeResponse, next

        #Assert
        expect(next).not.toHaveBeenCalled()
        expect(fakeHtmlSnapshot.take).toHaveBeenCalledWith fakeUrl, jasmine.any(Function)
        expect(fakeResponse.send).toHaveBeenCalledWith fakeHtml

    it 'should call next if not a search engine', () ->
        #Arrange
        fakeHtmlSnapshot =
            take: jasmine.createSpy 'take'

        fakeSearchEngineDetector =
            isSearchEngineBot: {}
        spyOn(fakeSearchEngineDetector, 'isSearchEngineBot').andReturn false

        fakeEscapeFragmentUtilities =
            isEscapedRequest: {}
        spyOn(fakeEscapeFragmentUtilities, 'isEscapedRequest').andReturn false
        
        fakeRequest =
            headers:
                'user-agent': 'webkit'
        
        fakeResponse =
            send: jasmine.createSpy 'res.send'

        middleware = new Middleware fakeHtmlSnapshot, fakeSearchEngineDetector, fakeEscapeFragmentUtilities

        #Act
        middleware.execute fakeRequest, fakeResponse, next

        #Assert
        expect(next).toHaveBeenCalled()
        expect(fakeHtmlSnapshot.take).not.toHaveBeenCalled()

    it 'should call next if a search engine user-agent is detected but an error happen in take', () ->
        #Arrange
        fakeHtmlSnapshot =
            take: {}
        spyOn(fakeHtmlSnapshot, 'take').andCallFake (url, callback) ->
            callback new Error()

        fakeSearchEngineDetector =
            isSearchEngineBot: {}
        spyOn(fakeSearchEngineDetector, 'isSearchEngineBot').andReturn true

        fakeEscapeFragmentUtilities =
            isEscapedRequest: {}
        spyOn(fakeEscapeFragmentUtilities, 'isEscapedRequest').andReturn false
        
        fakeRequest =
            protocol: 'http'
            originalUrl: '/search?q=openify.it'
            headers:
                host: 'localhost'
                'user-agent': 'googlebot'
        
        fakeResponse =
            send: jasmine.createSpy 'res.send'

        middleware = new Middleware fakeHtmlSnapshot, fakeSearchEngineDetector, fakeEscapeFragmentUtilities

        #Act
        middleware.execute fakeRequest, fakeResponse, next

        #Assert
        expect(next).toHaveBeenCalled()
        expect(fakeResponse.send).not.toHaveBeenCalled()

    it 'should call next if _escaped_fragment_ is detected but an error happen in take', () ->
        #Arrange
        fakeHtmlSnapshot =
            take: {}
        spyOn(fakeHtmlSnapshot, 'take').andCallFake (url, callback) ->
            callback new Error()

        fakeSearchEngineDetector =
            isSearchEngineBot: {}
        spyOn(fakeSearchEngineDetector, 'isSearchEngineBot').andReturn false

        fakeEscapeFragmentUtilities =
            isEscapedRequest: {}
            unescapeRequest: {}
        fakeUrl = 'http://localhost/#!/Home'
        spyOn(fakeEscapeFragmentUtilities, 'isEscapedRequest').andReturn true
        spyOn(fakeEscapeFragmentUtilities, 'unescapeRequest').andReturn fakeUrl
        
        fakeRequest =
            headers:
                'user-agent': 'webkit'
        
        fakeResponse =
            send: jasmine.createSpy 'res.send'

        middleware = new Middleware fakeHtmlSnapshot, fakeSearchEngineDetector, fakeEscapeFragmentUtilities

        #Act
        middleware.execute fakeRequest, fakeResponse, next

        #Assert
        expect(next).toHaveBeenCalled()
        expect(fakeResponse.send).not.toHaveBeenCalled()