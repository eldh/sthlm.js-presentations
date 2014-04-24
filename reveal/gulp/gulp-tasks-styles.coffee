exports.init = (gulp, logExit, logContinue, target, skipWatch) ->
	livereload = require("gulp-livereload")
	sass = require "gulp-sass"
	plumber = require "gulp-plumber"
	watch = require "gulp-watch"
	notify = require "gulp-notify"
	csso = require "gulp-csso"
	util = require "gulp-util"
	iconfont = require "gulp-iconfont"
	prefix = require "gulp-autoprefixer"
	iconfontCss = require "gulp-iconfont-css"
	runSequence = require "run-sequence"
	exec = require("child_process").exec
	environmentHelper = require "./environmentHelper"
	runAutoprefix = environmentHelper.get "autoprefixDev", "true"

	file = "src/styles/main.scss"
	includePaths = ["src/styles/*"]

	gulp.task "_styles", ->
		gulp.watch 'src/styles/**/*.scss', ['_compile-dev-styles']
		util.log '**WATCHING STYLES FOLDER**'

	gulp.task "_compile-dev-styles", ->
		gulp.src [file]
			.pipe plumber()
			.pipe sass
				includePaths: includePaths
				sourceComments: "map"
				file: file
			.on "error", (err) ->
				console.error err
				return
			.on "error", notify.onError (err) ->
				"Coffee error: " + err.message
			.pipe (if runAutoprefix is "false" then util.noop() else prefix "last 2 versions", "ie 10", "Android 4")
			.pipe gulp.dest "app/css"
			.pipe (if skipWatch is "true" then util.noop() else livereload(35730))
		return