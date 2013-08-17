async = require 'async'
Browser = require 'zombie'

class MemoryStore
    constructor: ()->
        @data = {}
    get: (key, callback) =>
        callback null, @data[key]
    set: (key, value, callback) =>
        @data[key] = value
        callback null, value

class ExpressHtmlSnapshots
    constructor: (@options = {}) ->
        #TODO ... store prefetched urls in a memory-store
        #in serveSnapshot ... if the url has been prefetched

        @store = null
        if not @options.store?
            @store = new MemoryStore()
        else if @options.store
            @store = @options.store


        if @options.prefetchUrls instanceof Array
            async.mapLimit @options.prefetchUrls, 10, @_preloadSnapshot, () =>

    googlebotMiddleware: () =>
        @middleware arguments...

    middleware: (req, res, next) =>
        if @_shouldServeSnapshot req
            @_serveSnapshot req, res, next
        else
            next()

    snapshot: (url, callback) =>
        browser = new Browser()
        browser.runScripts = true
        browser.visit url, (err, browser) =>
            callback err, browser.html()

    _preloadSnapshot: (url, callback) =>
        @snapshot url, (err, html) =>
            return callback err if err
            @store.set url, html, callback

    _serveSnapshot: (req, res, next) =>
        url = @_generateUrlFromRequest req
        if @store
            @store.get url, (err, html) =>
                if html
                    res.send html
                else
                    @snapshot url, @_onSnapshotTaken.bind(@, url, res, next)
        else
            @snapshot url, @_onSnapshotTaken.bind(@, url, res, next)

    _onSnapshotTaken: (url, res, next, err, html) =>
        return next() if err

        res.send html

        @store?.set url, html, () ->

    _shouldServeSnapshot: (req) =>
        return req.query['_escaped_fragment_']? or
            ( req.headers['user-agent']? and
                /googlebot|bingbot|yahoo/i.test(req.headers['user-agent']))

    _generateUrlFromRequest: (req) =>
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
