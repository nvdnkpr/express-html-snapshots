Browser = require 'zombie'

class ExpressHtmlSnapshots
    constructor: () ->
    googlebotMiddleware: () =>
        @middleware arguments...

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
        return req.query['_escaped_fragment_']? or
            ( req.headers['user-agent']? and
                /googlebot|bingbot|yahoo/i.test(req.headers['user-agent']))


    generateUrlFromRequest: (req) =>
        url = ""
        if req.query['_escaped_fragment_']?
            url = "#{req.protocol}://#{req.headers.host}#{req.path}#!#{req.query['_escaped_fragment_']}?"
            delete req.query['_escaped_fragment_']
            for key of req.query
                url += "#{key}=#{req.query[key]}&"
            url = url.replace /&$/g, ''
        else
            url = "#{req.protocol}://#{req.headers.host}#{req.originalUrl}"
        return url

module.exports = ExpressHtmlSnapshots
