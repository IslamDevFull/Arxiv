var gulp        = require('gulp');
var livereload = require('gulp-livereload');

gulp.task('livereload'), function() {

    gulp.src('cty.css')
        .pipe(livereload));

});

gulp.task('default',function) {
    livereload.listen();
    gulp.watch('cty.css', ['livereload']);
});