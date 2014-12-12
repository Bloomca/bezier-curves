(function() {
  require.config({
    paths: {
      "jquery": "../vendor/jquery-2.1.1",
      "underscore": "../vendor/underscore",
      "backbone": "../vendor/backbone",
      "jqueryui": "../vendor/jquery-ui.min"
    }
  });

  require(['app'], function(App) {
    return console.log("app started");
  });

}).call(this);
