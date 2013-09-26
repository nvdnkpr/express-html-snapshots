class EscapedFragmentUtilities
    
    isEscapedRequest: (request) =>
        return request.query._escaped_fragment_?

    unescapeRequest: (request) ->
        url = "#{request.protocol}://#{request.headers.host}#{request.path}#!#{request.query['_escaped_fragment_']}?"
        delete request.query['_escaped_fragment_']
        for key of request.query
            url += "#{key}=#{request.query[key]}&"
        url = url.replace /&$/g, ''
        return url

module.exports = EscapedFragmentUtilities
