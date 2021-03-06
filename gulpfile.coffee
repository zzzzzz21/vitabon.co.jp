gulp = require "gulp"
$ = require("gulp-load-plugins")({pattern: '*'})

autoprefixer = require "autoprefixer"
cmq = require "css-mqpacker"
cssnano = require "cssnano"
sorting = require "postcss-sorting"
prettify = require "postcss-prettify"

# PATH
SRC_ROOT = "./src"
DEV_ROOT = "./dev"
DIST_ROOT = "./dist"
TEMP = "./temp"

MODS = "node_modules"

SRC_FILES = [
  'gulpfile.coffee'
  'package.json'
  'package-lock.json'
]

SRC =
  pug: [
    "#{SRC_ROOT}/pug/**/*.pug"
    "!#{SRC_ROOT}/pug/_*/*.*"
  ]
  stylus: [
    "#{SRC_ROOT}/stylus/style.styl"
  ]
  coffee: [
    "#{SRC_ROOT}/coffee/**/*.coffee"
  ]

DEV =
  html: "#{DEV_ROOT}"
  css: "#{DEV_ROOT}/asset/css"
  js: "#{DEV_ROOT}/asset/js"
  lib: "#{DEV_ROOT}/asset/lib"

LIB = [
  {
    src: "#{MODS}/jquery/dist/jquery.min.js"
    dist: "jquery"
  }
  {
    src: "#{SRC_ROOT}/lib/StickyStack.js-master/jquery.stickystack.js"
    dist: "stickystack"
  }
  {
    src: "node_modules/fullpage.js/vendors/scrolloverflow.min.js"
    dist: "jquery.fullpage"
  }
  {
    src: "#{MODS}/fullpage.js/dist/jquery.fullpage.min.js"
    dist: "jquery.fullpage"
  }
  {
    src: "#{MODS}/fullpage.js/dist/jquery.fullpage.min.css"
    dist: "jquery.fullpage"
  }
]

WATCH =
  pug: "#{SRC_ROOT}/pug/**/*.pug"
  stylus: "#{SRC_ROOT}/stylus/**/*.styl"
  coffee: "#{SRC_ROOT}/coffee/**/*.coffee"

# ライブラリ
gulp.task "initialize", ->
  LIB.forEach (currentValue, index, array)->
    gulp
      .src currentValue.src
      .pipe gulp.dest "#{DEV.lib}/#{currentValue.dist}"

#server
gulp.task "server", ->
  $.browserSync.init
    server: {
      baseDir: DEV_ROOT
      # directory: true
    }
    port: 9001

gulp.task "html", ->
  gulp
    .src SRC.pug
    .pipe $.plumber
      errorHandler: $.notify.onError
        title: "HTML Error: Line <%= error.line %>"
        message: "<%= error.message %>"
    .pipe $.pug
      pretty: true
    .pipe gulp.dest DEV.html

gulp.task "css", ->
  gulp
    .src SRC.stylus
    .pipe $.plumber
      errorHandler: $.notify.onError
        title: "CSS Error: Line <%= error.line %>"
        message: "<%= error.message %>"
    .pipe $.stylus()
    .pipe $.postcss [
      autoprefixer
        browsers: ["last 2 versions"]
      cmq()
      sorting()
      cssnano()
      prettify()
    ]
    .pipe gulp.dest DEV.css

gulp.task "js", ->
  gulp
    .src SRC.coffee
    .pipe $.plumber
      errorHandler: $.notify.onError
        title: "JS Error: Line <%= error.line %>"
        message: "<%= error.message %>"
    .pipe $.coffee()
    .pipe gulp.dest DEV.js

gulp.task "watch", ->
  $.watch WATCH.pug, ->
    gulp.start "html"
  $.watch WATCH.stylus, ->
    gulp.start "css"
  $.watch WATCH.coffee, ->
    gulp.start "js"

# INSTALL(ライブラリのコピー)
gulp.task "install", ->
  $.runSequence(
    'initialize'
  )

# DEV
gulp.task "dev", (callback) ->
  $.runSequence(
    ["html", "css", "js"],
    callback
  )

# DEFAULT
gulp.task "default", (callback) ->
  $.runSequence(
    "dev",
    "server",
    "watch"
  )
