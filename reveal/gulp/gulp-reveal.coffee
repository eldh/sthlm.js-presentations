util = require "gulp-util"
rename = require "gulp-rename"
template = require "gulp-template"
watch = require "gulp-watch"
livereload = require "gulp-livereload"
markdown = require "gulp-markdown"
runSequence = require "run-sequence"
includer = require "gulp-htmlincluder"

exports.init = (gulp, logExit, logContinue, target, skipWatch) ->

	gulp.task "_reveal_include", ->
		gulp.src "src/slides/**/*.html"
			.pipe includer()
			.pipe gulp.dest 'app/'
			.pipe livereload(35730)
		return

	gulp.task '_reveal', ->
		gulp.watch "src/slides/**/*.*", ['_reveal_include']

