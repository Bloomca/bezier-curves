(function() {
  define(['models/point'], function(Point) {
    var Points;
    Points = Backbone.Collection.extend({
      model: Point
    });
    return Points;
  });

}).call(this);
