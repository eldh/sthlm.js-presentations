util = require "gulp-util"
rename = require "gulp-rename"
template = require "gulp-template"
watch = require "gulp-watch"
livereload = require "gulp-livereload"
markdown = require "gulp-markdown"

copyResources = (gulp, destination, skipWatch) ->
	gulp.src "src/resources/**/*"
		.pipe (if skipWatch is "true" then util.noop() else watch())
		.pipe gulp.dest destination
		.pipe (if skipWatch is "true" then util.noop() else livereload(35730))



exports.init = (gulp, logExit, logContinue, target, skipWatch) ->
	gulp.task "_dist-resources", ->
		copyResources gulp, target, 'true'
		return

	gulp.task "_watch-resources", ->
		gulp.watch "src/resources/**/*", ['_resources']

	gulp.task "_resources", ->
		copyResources gulp, "app/", skipWatch
		return

	gulp.task "_copy-resources", ->
		copyResources gulp, 'app/', 'true'
		return

	gulp.task "_dist-index-html", ->
		gulp.src "src/index.production.html"
			.pipe template tag: util.env.tag
			.pipe rename "index.html"
			.pipe gulp.dest target
		return

	gulp.task "_index-html", ->
		gulp.src "src/index.html"
			.pipe gulp.dest "app/"
		return

	return