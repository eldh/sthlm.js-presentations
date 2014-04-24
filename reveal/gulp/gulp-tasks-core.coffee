exports.init = (gulp, logExit, logContinue, fileserver) ->
	gulp = require "gulp"
	open = require "gulp-open"
	environmentHelper = require "./environmentHelper"
	skipWatch = environmentHelper.get "skipWatch", "false"

	gulp.task "default", [
		"build-app"
		"_watch-resources"
		"_styles"
		"_reveal"
		"_open"
	]
	gulp.task "build-app", [
		"_compile-dev-styles"
		# "_coffee"
		"_copy-resources"
		"_reveal_include"
	]

	gulp.task "git-hook", ["test-all"]

	gulp.task "coffee", ['_coffee']
	gulp.task "styles", ['_styles']
	gulp.task "dist", ['_dist']
	gulp.task "build-icons", ['_build-icons']
	gulp.task "reveal", ['_reveal']

	gulp.task "fileserver", ['_file-server']
	gulp.task "file-server", ['_file-server']
	gulp.task "dist-server", ['_dist-server']

	gulp.task "test-unit", ['_test-unit']
	gulp.task "test-unit-browser", ['_test-unit-browser']
	gulp.task "test-all", ['_test-all']
	gulp.task "watch-tests", ['_watch-tests']
	gulp.task "watch-integration-tests", ['_watch-integration-tests']
	gulp.task "watch-unit-tests", ['_watch-unit-tests']
	gulp.task "test-integration", ['_test-integration']
	gulp.task "test-integration-headless", ['_test-integration-headless']

	#open
	gulp.task "_open", ->
		fileserver.start "app", (url) ->
			options = url: url
			# An actual file must be specified or gulp will overlook the task.
			# The file is ignored.
			gulp.src "./app/index.html"
				.pipe open "", options
		return