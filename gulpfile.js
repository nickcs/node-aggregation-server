var gulp = require('gulp'),
        gutil = require('gulp-util'),
        coffee = require('gulp-coffee'),
        coffeelint = require('gulp-coffeelint'),
        sourcemaps = require('gulp-sourcemaps'),
        nodemon = require('gulp-nodemon'),
        concat = require('gulp-concat'),
        clean = require('gulp-clean'),
        runSequence = require('run-sequence'),
        _ = require('lodash'),
        mocha = require('gulp-mocha'),
        livereload = require('gulp-livereload');

var target = './dist';

var sources = {
  coffee: [
    {
      src: './*.coffee',
      target: target + '/'
    },
    {
      src: './plugins/**/*.coffee',
      target: target + '/plugins/'
    },
    {
      src: './routes/**/*.coffee',
      target: target + '/routes/'
    }
  ],
  static: [
    {
      src: './public/**/*.*',
      target: target + '/public'
    }
  ],
  tests: [
    {
      src: './test/**/*.coffee',
      target: './test/'
    }
  ]
};


gulp.task('develop', function () {
  process.env.NODE_ENV = 'develop';

  livereload.listen();
  nodemon({
    script: 'dist/server'
            //ext: 'js jade',
  }).on('restart', function () {
    setTimeout(function () {
      livereload.changed();
    }, 500);
  });
});

/**
 * Lint the files
 */
gulp.task('lint', function () {
  _.each(sources.coffee, function (path) {
    gulp.src(path.src)
      .pipe(coffeelint())
      .pipe(coffeelint.reporter());
  });
});

/**
 * Copy source files to dist
 */
gulp.task('src', function () {
  _.each(sources.static, function (path) {
    gulp.src(path.src)
      .pipe(gulp.dest(path.target));
  });
});

/**
 * Compile & lint the coffeescript files
 * AND add the app.js
 * AND mapp sourcefiles
 */
gulp.task('coffee', function () {

  _.each(sources.coffee, function (path) {
    gulp.src(path.src)
      .pipe(coffee())
      .pipe(gulp.dest(path.target));
  });

});

/**
 * Watch for changes
 */
gulp.task('watch', function () {
  gulp.watch(['./public/**/*.*'], ['src']);
  gulp.watch(['./routes/**/*.coffee','./plugins/**/*.coffee','./*.coffee'], ['lint', 'coffee']);
});

/**
 * Clean the dist folder
 */
gulp.task('clean', function () {
  gulp.src(['dist/**/*.*'], {read: false}).pipe(clean());
});

/**
 * Create the build task sequence chain
 */
gulp.task('build', function () {
  runSequence('clean', ['lint', 'src', 'coffee']);
});


/**
 * defualt `gulp`
 */
gulp.task('default', ['build', 'watch']);


gulp.task('test', function() {
  require('coffee-script/register');
  _.each(sources.tests, function(path){
    gulp.src(path.src, {read: false})
      .pipe(mocha({
          reporter: 'spec'
      }
      ));
  });
});
