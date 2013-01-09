
Browser = require 'zombie'

class ExpressHtmlSnapshots
    googlebotMiddleware: (req, res, next) =>
        if req.query['_escaped_fragment_']
            url = 'http://localhost:3000/#!' + req.query['_escaped_fragment_']
            @snapshot url, (err, html) =>
                console.log err
                res.send html
        else
            next()

    snapshot: (url, callback) =>
        browser = new Browser()
        browser.runScripts = true
        browser.visit url, (err, browser) =>
            if err
                callback err
            else
                callback null, browser.html()

module.exports = new ExpressHtmlSnapshots()
