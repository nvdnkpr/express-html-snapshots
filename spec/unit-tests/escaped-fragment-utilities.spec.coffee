describe 'escaped fragment utilities', () ->
    EscapedFragmentUtilities = require '../../src/escaped-fragment-utilities'
    escapedFragmentUtilities = null

    beforeEach () ->
        escapedFragmentUtilities = new EscapedFragmentUtilities()

    describe 'isEscapedRequest', () ->
        
        it 'should return true if the request is escaped', () ->
            fakeRequest = 
                query:
                    _escaped_fragment_: ''

            expect(escapedFragmentUtilities.isEscapedRequest fakeRequest).toBeTruthy()

            fakeRequest = 
                query:
                    _escaped_fragment_: 'liu'

            expect(escapedFragmentUtilities.isEscapedRequest fakeRequest).toBeTruthy()

        it 'should return false if the request is not escaped', () ->
            fakeRequest = 
                query: {}

            expect(escapedFragmentUtilities.isEscapedRequest fakeRequest).toBeFalsy()

    describe 'unescapeRequest', () ->
        
        it 'should recreate a pretty url from an ugly url', () ->
            fakeRequest =
                protocol: 'http'
                headers:
                    host: 'localhost'
                query:
                    _escaped_fragment_: 'home'
                    q: 'awesome query'
                originalUrl: '/?q=awesome query'
                path: '/'

            expectedUrl = 'http://localhost/#!home?q=awesome query'

            expect(escapedFragmentUtilities.unescapeRequest fakeRequest).toEqual expectedUrl
