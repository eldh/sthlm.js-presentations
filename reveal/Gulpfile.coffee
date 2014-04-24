gulp = require("gulp")
util = require("gulp-util")
environmentHelper = require("./gulp/environmentHelper")
fileserver = require("./gulp/fileserver.coffee")
target = environmentHelper.get("target", "dist/")
skipWatch = environmentHelper.get("skipWatch", "false")
logExit = (error) ->
  util.log util.colors.red(error)
  process.exit 1
  return

logContinue = (error) ->
  if skipWatch is "true"
    logExit()
  else
    util.log util.colors.red error
    @emit "end"
  return

require "./gulp/gulp-tasks-resources.coffee"
  .init gulp, logExit, logContinue, target, skipWatch

require "./gulp/gulp-reveal.coffee"
	.init gulp, logExit, logContinue, target, skipWatch

require "./gulp/gulp-tasks-styles.coffee"
	.init gulp, logExit, logContinue, target, skipWatch

require "./gulp/gulp-tasks-core.coffee"
	.init gulp, logExit, logContinue, fileserver

require "./gulp/gulp-tasks-fileserver.coffee"
	.init gulp, target, fileserver