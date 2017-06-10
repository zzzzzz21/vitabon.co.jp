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

LIB_JS = [
  "#{MODS}/jquery/dist/jquery.min.js"
  "#{MODS}/pagepiling.js/dist/jquery.pagepiling.min.js"
]

LIB_CSS = [
  "#{MODS}/pagepiling.js/dist/jquery.pagepiling.min.css"
]

WATCH =
  pug: "#{SRC}/pug/*.pug"
  stylus: "#{SRC}/stylus/*.styl"
  coffee: "#{SRC}/coffee/*.coffee"

# ライブラリ
gulp.task "init:js", ->
  gulp.src LIB_JS
    .pipe $.concat "vendor.js"
    .pipe gulp.dest DEV.js

gulp.task "init:css", ->
  gulp.src LIB_CSS
    .pipe $.concat "vendor.css"
    .pipe gulp.dest DEV.css

#server
gulp.task "server", ->
  $.browserSync.init
    server: {
      baseDir: './'
      directory: true
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
    'init:js'
    'init:css'
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
