
nodeio = require 'node.io'

class JobFactory
    @create: (url) ->
        jobOptions =
            jsdom: true,
            external_resources: ['script']
        methods = 
            input: [url]
            run: (item) ->
                @getHtml item, (err, $, data, headers, response) ->
                    @emit $('html').html()

        return new nodeio.Job jobOptions, methods



module.exports.middleware = (req, res, next) ->
    if req.query['_escaped_fragment_']
        url = 'http://localhost:3000/#!' + req.query['_escaped_fragment_']
        job = JobFactory.create url
        callback = (err, output) ->
            res.send output[0]
        captureOutput = true
        processOptions = {}
        nodeio.start job, processOptions, callback, captureOutput
    else
        next()
