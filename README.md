#express-html-snapshots

[![Build Status](https://travis-ci.org/OpenifyIt/express-html-snapshots.png?branch=master)](https://travis-ci.org/OpenifyIt/express-html-snapshots)

Provides a useful middleware for express that allows heavy javascript web applications to be crawled by search engines.

## How to install

    npm install express-html-snapshots

## How to run tests

    npm install
    npm test

## How to use

You can take a look at the sample application (https://github.com/OpenifyIt/express-html-snapshots/tree/master/samples/angularjs)

Otherwise it's really straight forward.

    expressHTMLSnapshots = require 'express-html-snapshots'

    app.configure () ->
        # ...
        app.use expressHTMLSnapshots.middleware # it must be placed before the app.router
        app.use app.router
        # ...

You can also use directly the snapshot function

    expressHTMLSnapshots = require 'express-html-snapshots'

    expressHTMLSnapshots.snapshopt url, (err, html) ->
        console.log err, html
        # do awesome things with the snapshot

## TODOS
* Create static snapshot files
* Serve a static snapshot if it exists
* More doc
* More tests
* ...

## Contributions
Contributions are welcome! Make sure include tests with your pull request.

##Issues
If you find an issue, please specified the steps to reproduce it. If you can provide a script to reproduce the issue.

Thanks
