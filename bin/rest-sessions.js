#!/usr/bin/env node --max-old-space-size=32

var path = require('path');
var fs   = require('fs');
var _path  = path.join(path.dirname(fs.realpathSync(__filename)), '../');

require(_path + 'server.js');
