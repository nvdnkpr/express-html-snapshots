describe 'unit tests html snapshots', () ->
    
    HtmlSnapshot = require '../../src/html-snapshot'
    Browser = require 'zombie'
    browser = null
    htmlSnapshot = null
    callback = null
    fakeHtml = null
    
    beforeEach () ->
        browser = new Browser()
        fakeHtml = '<html><head></head><body>Hello</body></html>'

        spyOn(browser, 'visit').andCallFake (url, callback) ->
            callback null, browser

        spyOn(browser, 'html').andCallFake () ->
            return fakeHtml

        htmlSnapshot = new HtmlSnapshot browser

        callback = jasmine.createSpy 'callback'

    describe 'take', () ->

        it 'should return the html from a valid url', () ->
            #TODO expect browser.visit to have been call with the url
            #TODO expect browser.html() to have been call in the callback
            url = 'http://example.com'
            htmlSnapshot.take url, callback

            expect(browser.visit).toHaveBeenCalledWith url, jasmine.any(Function)
            expect(browser.html).toHaveBeenCalled()
            expect(callback).toHaveBeenCalledWith null, fakeHtml

        it 'should return an InvalidUrlError if an invalid url is provided', () ->
            #TODO expect take() to return InvalidUrlError

            url = 'invalid url'
            htmlSnapshot.take url, callback

            expect(browser.visit).not.toHaveBeenCalled()
            expect(browser.html).not.toHaveBeenCalled()
            expect(callback).toHaveBeenCalledWith jasmine.any(Error)
