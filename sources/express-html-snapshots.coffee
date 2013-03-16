
Browser = require 'zombie'

class ExpressHtmlSnapshots
    googlebotMiddleware: (req, res, next) =>
        if req.query['_escaped_fragment_']
            url = "#{req.protocol}://#{req.header('host')}?#{req.query['_escaped_fragment_']}"
            @snapshot url, (err, html) =>
                if err
                    #In case of error, return the page as is
                    next()
                else
                    res.send html
        else if req.headers['user-agent'] and req.headers['user-agent'].indexOf('Googlebot') >= 0
            url = "#{req.protocol}://#{req.get('host')}#{req.url}"
            @snapshot url, (err, html) =>
                if err
                    #In case of error, return the page as is
                    next()
                else
                    res.send html
        else
            next()

    snapshot: (url, callback) =>
        browser = new Browser()
        browser.runScripts = true
        browser.visit url, (err, browser) =>
            callback err, browser.html()

module.exports = new ExpressHtmlSnapshots()
