// REQUIRED
var gulp      = require('gulp'),
    gutil     = require('gulp-util'),
    bower     = require('bower'),
    concat    = require('gulp-concat'),
    sass      = require('gulp-sass'),
    minifyCss = require('gulp-minify-css'),
    rename    = require('gulp-rename'),
    sh        = require('shelljs'),
    coffee    = require('gulp-coffee'),
    uglify    = require('gulp-uglify');

// PATHS
var paths = {
  sass: ['./scss/**/*.scss'],
  coffee: [ 
    './coffee/autoload.coffee',
    './coffee/pre.coffee',
    './coffee/app_*.coffee',
    './coffee/post.coffee'
  ]
};


gulp.task('sass', function(done) {
  gulp.src('./scss/ionic.app.scss')
    .pipe(sass())
    .pipe(gulp.dest('./www/css/'))
    .pipe(minifyCss({
      keepSpecialComments: 0
    }))
    .pipe(rename({ extname: '.min.css' }))
    .pipe(gulp.dest('./www/css/'))
    .on('end', done);
});
gulp.task( 'sass:watch', function()
{
  gulp.watch( paths.sass, [ 'sass' ] );
});

gulp.task('coffee', function( done )
{
  gulp.src( paths.coffee )
    .pipe( coffee({ bare: true }).on( 'error', gutil.log ) )
    .pipe( concat('application.js') )
    .pipe( gulp.dest( './www/js/' ) )
    .pipe( uglify({ mangle:false, compress: true }) )
    .pipe( rename({ suffix: '.min'}) )
    .pipe( gulp.dest( './www/js/' ) )
    .on( 'end', done );
});
gulp.task( 'coffee:watch', ['coffee'], function()
{
  gulp.watch( paths.coffee, [ 'coffee' ] );
});


gulp.task('watch', function() {
  gulp.watch( paths.sass, ['sass'] );
  gulp.watch( paths.coffee, ['coffee'] );
});

gulp.task('install', ['git-check'], function() {
  return bower.commands.install()
    .on('log', function(data) {
      gutil.log('bower', gutil.colors.cyan(data.id), data.message);
    });
});

gulp.task('git-check', function(done) {
  if (!sh.which('git')) {
    console.log(
      '  ' + gutil.colors.red('Git is not installed.'),
      '\n  Git, the version control system, is required to download Ionic.',
      '\n  Download git here:', gutil.colors.cyan('http://git-scm.com/downloads') + '.',
      '\n  Once git is installed, run \'' + gutil.colors.cyan('gulp install') + '\' again.'
    );
    process.exit(1);
  }
  done();
});

// DEFAULT TASKS
gulp.task('default', ['sass', 'coffee']);

gulp.task('development', ['default', 'watch']);

