
expect = require 'expect.js'
server = require '../samples/angularjs/server'
Browser = require 'zombie'

describe 'test express html snapshots', () ->

    before (done) ->
        this.browser = new Browser()
        this.browser.runScripts = false
        this.browser.on 'error', (err) =>
            console.log err
        server.start done

    after (done) ->
        this.browser.close()
        server.close done

    it 'should render the website for google search bot', (done) ->
        url = 'http://localhost:3000/?_escaped_fragment_=%2Fhome'
        this.browser.visit url, (err, browser) ->
            expect(err).not.to.be.ok()
            expect(browser.success).to.be.ok()
            expect(browser.statusCode).to.be.eql(200)
            expect(browser.text('#content')).to.be.eql('Generated on client-side')
            done()
