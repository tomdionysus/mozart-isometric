path = require "path"

module.exports = (grunt) ->
  grunt.registerTask 'testServer', 'Starts the integration server stub', ->
    process.env.NODE_ENV = 'development'
    require "../../server"