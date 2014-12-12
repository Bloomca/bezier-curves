(function() {
  define(['jquery', 'underscore', 'backbone'], function($, _, Backbone) {
    var Point;
    Point = Backbone.Model.extend({
      defaults: {
        x: 100,
        y: 100
      }
    });
    return Point;
  });

}).call(this);
