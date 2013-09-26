validator = require 'validator'

class HtmlSnapshot

    constructor: (@browser) ->

    take: (url, callback) =>
        try
            validator.check(url).isUrl()
            @browser.visit url, (err) =>
                callback err, @browser.html()
        catch e
            callback e

module.exports = HtmlSnapshot
