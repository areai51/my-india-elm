'use strict';

//require('jquery');
//require('tether');
require('bootstrap');
require('bootstrap/dist/css/bootstrap.css');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.body;

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);