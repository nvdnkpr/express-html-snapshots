
Browser = require 'zombie'

module.exports.middleware = (req, res, next) ->
    if req.query['_escaped_fragment_']
        url = 'http://localhost:3000/#!' + req.query['_escaped_fragment_']

        browser = new Browser()
        browser.runScripts = true
        browser.visit url, (err, browser) ->
            console.log err
            res.send browser.html()
    else
        next()
