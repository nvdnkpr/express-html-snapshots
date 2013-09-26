module.exports = (grunt) ->

    config =
        clean:
            build: ['./build']
        coffee:
            compile:
                files: [{
                    expand: true
                    cwd: './src/'
                    src: ['./**/*.coffee']
                    dest: './build/'
                    ext: '.js'
                }]
                options:
                    bare: true
        jasmine_node:
            forceExit: true
            extensions: 'coffee'
            isVerbose: true
            useCoffee: true


    grunt.initConfig config

    grunt.loadNpmTasks 'grunt-contrib-coffee'
    grunt.loadNpmTasks 'grunt-contrib-clean'
    grunt.loadNpmTasks 'grunt-jasmine-node'

    grunt.registerTask 'build', ['clean:build', 'coffee:compile']
    grunt.registerTask 'default', ['build', 'jasmine_node']
