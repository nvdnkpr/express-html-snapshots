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
        expect(ehs.generateUrlFromRequest fakeRequest).toEqual 'http://localhost/#!home?q=awesome query'

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
        expect(ehs.generateUrlFromRequest fakeRequest).toEqual 'http://localhost/#!?q=awesome query'

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
        expect(ehs.generateUrlFromRequest fakeRequest).toEqual 'http://localhost/home#!?q=awesome query'

    it 'should recreate the url without the hashbang and without _escaped_fragment_', () ->
        fakeRequest =
            protocol: 'http'
            headers:
                host: 'localhost'
            query:
                q: 'awesome query'
            originalUrl: '/home?q=awesome query'
        expect(ehs.generateUrlFromRequest fakeRequest).toEqual 'http://localhost/home?q=awesome query'

    it 'should determinte wheter or not to server a snapshopt or not', () ->
        fakeRequest =
            headers:
                'user-agent': 'Chrome'
            query:
                _escaped_fragment_: 'kth'
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'Chrome'
            query:
                _escaped_fragment_: ''
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'googlebot'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'GoogleBot'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'bingbot'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'BingBot'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'Yahoo'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'yahoo'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeTruthy()

        fakeRequest =
            headers:
                'user-agent': 'Chrome'
            query: {}
        expect(ehs.shouldServeSnapshot fakeRequest).toBeFalsy()


    it 'should pass arguments from "googlebotMiddleware" to "middleware"', () ->
        spyOn ehs, 'middleware'

        fakeRequest =
            query:
                q: 'awesome'
        fakeResponse =
            send: () ->
        fakeNext = () ->

        ehs.googlebotMiddleware fakeRequest, fakeResponse, fakeNext
        expect(ehs.middleware).toHaveBeenCalledWith fakeRequest, fakeResponse, fakeNext
