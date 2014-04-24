exports.init = (gulp, target, fileserver) ->
	gulp.task "_file-server", (started) ->
		fileserver.start "app", () -> started
		return

	gulp.task "_dist-server", (started) ->
		fileserver.start target, () -> started
		return

	return