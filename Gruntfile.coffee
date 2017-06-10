module.exports = (grunt) ->
  'use strict'

  TEMP = "temp"
  SRC = "src"
  DEV = "dev"
  LIB = "asset/lib"
  DIST = "dist"
  MEZZ = "mezzanine"
  CSS = "asset/css"
  IMG = "image"
  JS = "asset/js"

  require('load-grunt-config') grunt,
    init: true
    data: config:
      publish: DEV
      temp: TEMP
      src:
        root: SRC
        pug: "#{SRC}/pug"
        stylus: "#{SRC}/stylus"
        coffee: "#{SRC}/coffee"
        mezzanine: MEZZ
        image: "#{SRC}/image"
        html: "#{SRC}/html"
      dev:
        root: DEV
        html: DEV
        image: "#{DEV}/#{IMG}"
        lib: "#{DEV}/#{LIB}"
        js: "#{DEV}/#{JS}"
        stylus: "#{MEZZ}/css_raw"
        autoprefixer: "#{MEZZ}/css_prefixed"
        combine_mq: "#{MEZZ}/css_mq_combined"
        cssmin: "#{MEZZ}/css_minified"
        csscomb: "#{DEV}/#{CSS}"
      dist:
        root: DIST
        html: DIST
        image: "#{DIST}/#{IMG}"
        lib: "#{DIST}/#{LIB}"
        js: "#{DIST}/#{JS}"
        cssmin: "#{DIST}/#{CSS}"
        csscomb: "#{MEZZ}/css_combed"
      init:[
        {
          expand: true
          cwd: 'node_modules/photoswipe/dist'
          src: [
              'default-skin/*.*'
              'photoswipe.min.js'
              'photoswipe-ui-default.min.js'
              'photoswipe.css'
            ]
          dest: "#{DEV}/#{LIB}/photoswipe"
        }
      ]
