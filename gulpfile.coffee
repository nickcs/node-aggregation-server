gulp = require("gulp")
gutil = require("gulp-util")
coffee = require("gulp-coffee")
coffeelint = require("gulp-coffeelint")
sourcemaps = require("gulp-sourcemaps")
nodemon = require("gulp-nodemon")
concat = require("gulp-concat")
clean = require("gulp-clean")
runSequence = require("run-sequence")
_ = require("lodash")
mocha = require("gulp-mocha")
livereload = require("gulp-livereload")
target = "./dist"
sources =
  coffee: [
    src: "./*.coffee"
    target: target + "/"
  ,
    src: "./public/components/**/*.coffee"
    target: target + "/public/components/"
  ,
    src: "./routes/**/*.coffee"
    target: target + "/routes/"
   ]
  static: [
    src: "./public/**/*.*"
    target: target + "/public"
  ,
    src: "./views/**/*.jade"
    target: target + "/views"
   ]
  tests: [
    src: "./test/**/*.coffee"
    target: "./test/"
   ]

gulp.task "develop", ->
  livereload.listen()

  #ext: 'js jade',
  nodemon(script: "dist/server").on "restart", ->
    setTimeout (->
      livereload.changed()
    ), 500



###
Lint the files
###
gulp.task "lint", ->
  _.each sources.coffee, (path) ->
    gulp.src(path.src).pipe(coffeelint()).pipe coffeelint.reporter()



###
Copy source files to dist
###
gulp.task "src", ->
  _.each sources.static, (path) ->
    gulp.src(path.src).pipe gulp.dest(path.target)



###
Compile & lint the coffeescript files
AND add the app.js
AND mapp sourcefiles
###
gulp.task "coffee", ->
  _.each sources.coffee, (path) ->
    gulp.src(path.src).pipe(coffee()).pipe gulp.dest(path.target)



###
Watch for changes
###
gulp.task "watch", ->
  gulp.watch [ "./public/**/*.*" ], [ "src" ]
  gulp.watch [
    "./routes/**/*.coffee",
    "./public/components/**/*.coffee",
    "./*.coffee" ],
    [ "lint", "coffee" ]


###
Clean the dist folder
###
gulp.task "clean", ->
  gulp.src([ "dist/**/*.*" ],
    read: false
  ).pipe clean()


###
Create the build task sequence chain
###
gulp.task "build", ->
  runSequence [ "lint", "src", "coffee" ]


###
defualt `gulp`
###
gulp.task "default", [ "build", "watch", "develop" ]
gulp.task "test", ->
  require "coffee-script/register"
  _.each sources.tests, (path) ->
    gulp.src(path.src,
      read: false
    ).pipe mocha(reporter: "spec")

