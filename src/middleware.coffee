class Middleware

    constructor: (@htmlSnapshot, @searchEngineDetector, @espacedFragmentUtilities) ->

    execute: (req, res, next) =>
        if @espacedFragmentUtilities.isEscapedRequest req
            url = @espacedFragmentUtilities.unescapeRequest req
            @htmlSnapshot.take url, (err, html) =>
                if err
                    next()
                else
                    res.send html
        else if @searchEngineDetector.isSearchEngineBot req.headers['user-agent']
            url = "#{req.protocol}://#{req.headers.host}#{req.originalUrl}"
            @htmlSnapshot.take url, (err, html) =>
                if err
                    next()
                else
                    res.send html
        else
            next()

module.exports = Middleware