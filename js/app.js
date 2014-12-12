(function() {
  define(['views/appView', 'collections/points'], function(AppView, Points) {
    var appView, points;
    points = new Points([
      {
        x: 100,
        y: 100
      }, {
        x: 500,
        y: 100
      }, {
        x: 100,
        y: 500
      }, {
        x: 500,
        y: 500
      }
    ]);
    return appView = new AppView({
      collection: points
    });
  });

}).call(this);
