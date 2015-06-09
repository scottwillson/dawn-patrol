'use strict';

var gulp = require('gulp');
var babel = require('gulp-babel');

gulp.task('watch', function() {
  gulp.watch(['src/*.js', 'test/*.js'], ['transpile']);
});

gulp.task('transpile', function () {
  return gulp.src(['src/*.js', 'test/*.js'])
    .pipe(babel())
    .pipe(gulp.dest('dist'));
});

gulp.task('default', ['transpile', 'watch']);
