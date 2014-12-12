(function() {
  define(['jquery', 'underscore', 'backbone', 'utils/canvas', 'jqueryui'], function($, _, Backbone, utils) {
    var PointView;
    return PointView = Backbone.View.extend({
      className: "bezierPoint",
      events: {
        "dblclick": "removePoint"
      },
      initialize: function() {
        this.$el.draggable({
          containment: "parent",
          start: (function(_this) {
            return function() {
              return utils.trigger("drag:start");
            };
          })(this),
          stop: (function(_this) {
            return function() {
              return utils.trigger("drag:stop");
            };
          })(this),
          drag: ((function(_this) {
            return function() {
              var time;
              time = Date.now();
              return function(evt, ui) {
                var p;
                if (Date.now() - time < 20) {
                  return;
                } else {
                  time = Date.now();
                  utils.trigger("dragging");
                }
                p = ui.position;
                return _this.model.set({
                  x: p.left + 10,
                  y: p.top + 10
                });
              };
            };
          })(this))()
        });
        return this.drawPoint();
      },
      drawPoint: function() {
        return this.$el.css({
          left: this.model.get('x') - 10 + "px",
          top: this.model.get('y') - 10 + "px"
        });
      },
      removePoint: function() {
        this.model.destroy();
        return this.remove();
      }
    });
  });

}).call(this);
