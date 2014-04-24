http = require "http"
portfinder = require "portfinder"
reactFileserver = require "../fileserver/fileserver"
server = undefined

exports.start = (reactAppPath, started, options) ->
	portfinder.getPort (err, port) ->
		app = new reactFileserver reactAppPath, options
		server = http.createServer app
		server.listen 1337
		console.log 'Using port ' + 1337
		started("http://localhost:"+1337)
	return

exports.stop = () ->
	server.close()

return exports