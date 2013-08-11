Browser = require 'zombie'

class ExpressHtmlSnapshots
    constructor: () ->
    googlebotMiddleware: (req, res, next) =>
        #backward compatibility
        @middleware req, res, next

    middleware: (req, res, next) =>
        if @shouldServeSnapshot req
            @serveSnapshot req, res, next
        else
            next()

    serveSnapshot: (req, res, next) =>
        @snapshot @generateUrlFromRequest(req), (err, html) =>
            if err
                #In case of error, return the page as is
                next()
            else
                res.send html

    snapshot: (url, callback) =>
        browser = new Browser()
        browser.runScripts = true
        browser.visit url, (err, browser) =>
            callback err, browser.html()

    shouldServeSnapshot: (req) =>
        return req.query['_escaped_fragment_'] or
            ( req.headers['user-agent'] and
            (req.headers['user-agent'].indexOf('Googlebot') >= 0 or
            req.headers['user-agent'].indexOf('bingbot') >= 0 or
            req.headers['user-agent'].indexOf('Yahoo! Slurp') >= 0))

    generateUrlFromRequest: (req) =>
        url = ""
        if req.query['_escaped_fragment_']
            url = "#{req.protocol}://#{req.header('host')}/#!#{req.query['_escaped_fragment_']}?"
            delete req.query['_escaped_fragment_']
            for key of req.query
                url += "#{key}=#{req.query[key]}&"
        else
            url = "#{req.protocol}://#{req.header('host')}#{req._parsedUrl.path}"
        return url

module.exports = new ExpressHtmlSnapshots()
