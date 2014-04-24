/**
 * Minimal static file web server to test drive the site
 */

var _ = require('lodash'),
	express = require('express'),
	url = require('url');

// Poor man's node.js express mod_rewrite
function rewrite(paths, replacement) {
	// Form a regular expression of the given paths for rewriting the URLs
	var pathsRE = paths.join('|'),
		fullRE = [ '^\/(', pathsRE ,')' ].join(''),
		re = new RegExp(fullRE);

	return function (req, res, next) {
		var parsed = url.parse(req.url),
		original = req.url;

		// Rewrite urls of form /tasks/foobar
		if (parsed.pathname.match(re)) {
			// /tasks/123456
			parsed.pathname = parsed.pathname.replace(re, replacement);
			req.url = url.format(parsed);
			console.log('Rewrote', original, 'to', req.url);
		}
		next();
	}
}

function getApp(servePath, options) {
	var app = express();
	app.configure(function() {
		app.use(rewrite([
			'reportdata.*',
			'report.*',
			'login.*',
			'logout.*',
			'doLogin.*'
			], ''));
		app.use(express.static(servePath));
	});
	return app;
}

module.exports = getApp;