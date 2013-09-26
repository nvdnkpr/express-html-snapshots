#express-html-snapshots

[![Build Status](https://travis-ci.org/OpenifyIt/express-html-snapshots.png?branch=master)](https://travis-ci.org/OpenifyIt/express-html-snapshots)

[![Dependency Status](https://gemnasium.com/OpenifyIt/express-html-snapshots.png)](https://gemnasium.com/OpenifyIt/express-html-snapshots)


Provides a useful middleware for express that allows heavy javascript web applications to be crawled by search engines.

## How to install

    npm install --save express-html-snapshots

## How to run tests

    npm install
    npm test

## How to use

You can take a look at the sample application (https://github.com/OpenifyIt/express-html-snapshots/tree/master/samples/angularjs)

Otherwise it's really straight forward.

    app.configure(function(){
        // ...
        app.use(require('express-html-snapshots').middleware);
        app.use(app.router);
        // ...
    });

## TODOS
* Create static snapshots
* Serve a static snapshot if it exists
* More doc
* Extract HtmlSnapshot into a diffent package
* End to end tests

## Contributions
Contributions are welcome! Make sure to include tests with your pull request.

##Issues
If you find an issue, please specified the steps to reproduce it. If you can provide a script to reproduce the issue, it's even better!.

Thanks
