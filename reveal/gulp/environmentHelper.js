var util = require('gulp-util');

var environmentHelper = function (util) {

    var logInfo = function (key, value, valueType) {
        util.log('Variable', valueType, util.colors.blue(key), util.colors.magenta(value));
        util.log('You may set the ' + key + ' with --' + key);
    };

    var get = function (key, fallbackValue) {
        var value = util.env[key];
        var valueType = 'value';
        if (typeof value === 'undefined') {
            value = fallbackValue;
            valueType = 'fallbackValue';
        }
        logInfo(key, value, valueType);
        return value;
    };

    return { get: get};
}(util);

exports.get = environmentHelper.get;