'use strict';

require('./assets/normalize.css');
require('./assets/main.css');

// Require index.html so it gets copied to dist
require('./index.html');

var Elm = require('./Main.elm');
var mountNode = document.body;

// .embed() can take an optional second argument. This would be an object describing the data we need to start a program, i.e. a userID or some token
var app = Elm.Main.embed(mountNode);
var requestAnimationFrame =
       window.requestAnimationFrame ||
       window.mozRequestAnimationFrame ||
       window.webkitRequestAnimationFrame ||
       window.msRequestAnimationFrame;

var renderChartCallback = function(chartType) {
  requestAnimationFrame(function() {
    if(document.getElementById('bar-chart') !== null) {
      console.log(chartType.toUpperCase());
    }
  });
}

app.ports.renderChart.subscribe(renderChartCallback);
