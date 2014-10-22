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
        livereload = require('gulp-livereload');

var target = './dist';

var sources = {
  coffee: [
    {
      src: './app.coffee',
      target: target + '/'
    },
    {
      src: './public/components/**/*.coffee',
      target: target + '/public/components/'
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
    },
    {
      src: './views/**/*.jade',
      target: target + '/views'
    }
  ]
};


gulp.task('develop', function () {
  livereload.listen();
  nodemon({
    script: 'bin/www'
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
  gulp.watch(['./routes/**/*.coffee','./public/components/**/*.coffee','./app.coffee'], ['lint', 'coffee']);
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
gulp.task('default', ['build', 'watch', 'develop']);