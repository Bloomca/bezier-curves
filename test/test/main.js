/*globals describe, it */
require.config({
  urlArgs: 'cb=' + Math.random(),
  baseUrl: "../app/js/",
  paths: {
    "jquery": "../vendor/jquery-2.1.1",
    "underscore": "../vendor/underscore",
    "backbone": "../vendor/backbone",
    "jqueryui": "../vendor/jquery-ui.min",
    "jasmine": "../../test/lib/jasmine-2.1.3/jasmine",
    "jasmine-html": "../../test/lib/jasmine-2.1.3/jasmine-html",
    'boot': "../../test/lib/jasmine-2.1.3/boot"
  },
  shim: {
    jasmine: {
      exports: 'jasmine'
    },
    'jasmine-html': {
      deps: ['jasmine'],
      exports: 'jasmine'
    },
    'boot': {
      deps: ['jasmine', 'jasmine-html'],
      exports: 'window.jasmineRequire'
    }
  }
});

var specs = [
  "../../test/test/spec"
];

require(['boot'], function(){

  require(specs, function () {

    // Initialize the HTML Reporter and execute the environment (setup by `boot.js`)
    window.onload();
  });
});