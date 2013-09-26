describe 'index', () ->
    ehs = require '../..'
    Middleware = require '../../build/middleware'
    EscapedFragmentUtilities = require '../../build/escaped-fragment-utilities'
    HtmlSnapshot = require '../../build/html-snapshot'
    SearchEngineDetector = require '../../build/search-engine-detector'


    it 'should export everything', () ->
        
        expect(ehs.Middleware).toEqual Middleware
        expect(ehs.EscapedFragmentUtilities).toEqual EscapedFragmentUtilities
        expect(ehs.HtmlSnapshot).toEqual HtmlSnapshot
        expect(ehs.SearchEngineDetector).toEqual SearchEngineDetector
        
        expect(ehs.middleware instanceof Function).toBeTruthy()

        
