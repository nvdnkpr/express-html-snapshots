ExpressHtmlSnapshots = require '../'

describe 'unit tests', () ->
    ehs = new ExpressHtmlSnapshots()
    it 'should recreate the url with the hashbang', () ->
        fakeRequest =
            protocol: 'http'
            headers:
                host: 'localhost'
            query:
                _escaped_fragment_: 'home'
                q: 'awesome query'
            originalUrl: '/?q=awesome query'
            path: '/'
        expect(ehs._generateUrlFromRequest fakeRequest).toEqual 'http://localhost/#!home?q=awesome query'

    it 'should recreate the url with the hashbang and an empty _escaped_fragment_', () ->
        fakeRequest =
            protocol: 'http'
            headers:
                host: 'localhost'
            query:
                _escaped_fragment_: ''
                q: 'awesome query'
            originalUrl: '/?q=awesome query'
            path: '/'
        expect(ehs._generateUrlFromRequest fakeRequest).toEqual 'http://localhost/#!?q=awesome query'

    it 'should recreate the url with the hashbang and an empty _escaped_fragment_ when not a the base path', () ->
        fakeRequest =
            protocol: 'http'
            headers:
                host: 'localhost'
            query:
                _escaped_fragment_: ''
                q: 'awesome query'
            originalUrl: '/home?q=awesome query'
            path: '/home'
        expect(ehs._generateUrlFromRequest fakeRequest).toEqual 'http://localhost/home#!?q=awesome query'

    it 'should recreate the url without the hashbang and without _escaped_fragment_', () ->
        fakeRequest =
            protocol: 'http'
            headers:
                host: 'localhost'
            query:
                q: 'awesome query'
            originalUrl: '/home?q=awesome query'
        expect(ehs._generateUrlFromRequest fakeRequest).toEqual 'http://localhost/home?q=awesome query'

    it 'should determinte wheter or not to server a snapshopt or not', () ->
        fakeRequest =
            headers:
                'user-agent': 'Chrome'
            query:
                _escaped_fragment_: 'kth'
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'Chrome'
            query:
                _escaped_fragment_: ''
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'googlebot'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'GoogleBot'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'bingbot'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'BingBot'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'Yahoo'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'yahoo'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'Chrome'
            query: {}
        expect(ehs._shouldServeSnapshot fakeRequest).toBeFalsy()

    it 'should pass arguments from "googlebotMiddleware" to "middleware" (backward compatibility)', () ->
        spyOn ehs, 'middleware'
        fakeRequest =
            query:
                q: 'awesome'
        fakeResponse =
            send: () ->
        fakeNext = () ->
        ehs.googlebotMiddleware fakeRequest, fakeResponse, fakeNext

        expect(ehs.middleware).toHaveBeenCalledWith fakeRequest, fakeResponse, fakeNext

    it 'should call snapshot for each url provided in the options prefetchUrls', () ->
        options =
            prefetchUrls: [
                'https://www.google.ca'
                'https://www.openify.it'
            ]

        spyOn(ExpressHtmlSnapshots.prototype, 'snapshot').andCallFake (url, callback) ->
            callback null, "<html><head><title>#{url}</title></head><body>Hello</body></html>"
        ehs = new ExpressHtmlSnapshots options

        expect(ExpressHtmlSnapshots.prototype.snapshot.callCount).toEqual 2
        expect(ExpressHtmlSnapshots.prototype.snapshot.calls[0].args[0]).toEqual 'https://www.google.ca'
        expect(ExpressHtmlSnapshots.prototype.snapshot.calls[1].args[0]).toEqual 'https://www.openify.it'

    xit 'should serve a prefetched url', () ->
    xit 'should not perform a prefetched url lookup if disabled ("store = false")', () ->

    it 'should create a memory-store by default', () ->
        ehs = new ExpressHtmlSnapshots()
        expect(ehs.store).toEqual jasmine.any(Object)
        expect(ehs.store.get).toEqual jasmine.any(Function)
        expect(ehs.store.set).toEqual jasmine.any(Function)

    it 'should use the store if one is given', () ->
        options =
            store:
                get: (key, callback) ->
                set: (key, value, callback) ->

        ehs = new ExpressHtmlSnapshots options
        expect(ehs.store).toBe options.store

    it 'should store html once fetched', () ->
        ehs = new ExpressHtmlSnapshots()
        spyOn ehs.store, 'set'

        fakeRequest =
            headers:
                'user-agent': 'yahoo'
                host: 'localhost'
            protocol: 'http'
            originalUrl: '/home'
            query: {}
        fakeResponse =
            send: jasmine.createSpy 'send'
        fakeNext = jasmine.createSpy 'next'
        fakeHtml = "<html><head><title>Hello</title></head><body>World!</body></html>"
        spyOn(ehs, 'snapshot').andCallFake (url, callback) ->
            callback null, fakeHtml

        expectUrl = 'http://localhost/home'

        ehs.middleware fakeRequest, fakeResponse, fakeNext

        expect(ehs.store.set.callCount).toEqual 1
        expect(ehs.store.set.calls[0].args[0]).toEqual expectUrl
        expect(ehs.store.set.calls[0].args[1]).toEqual fakeHtml

    it 'should preload prefetchUrls', () ->
        options =
            prefetchUrls: [
                'http://www.openify.it/'
            ]
            store:
                set: jasmine.createSpy 'set'

        fakeHtml = "<html><head><title>Hello</title></head><body>World!</body></html>"
        spyOn(ExpressHtmlSnapshots.prototype, 'snapshot').andCallFake (url, callback) ->
            callback null, fakeHtml

        ehs = new ExpressHtmlSnapshots options

        expect(ehs.store.set.callCount).toEqual 1
        expect(ehs.store.set.calls[0].args[0]).toEqual options.prefetchUrls[0]
        expect(ehs.store.set.calls[0].args[1]).toEqual fakeHtml
