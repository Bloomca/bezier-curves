(function() {
  define(['jquery', 'underscore', 'backbone', 'views/pointView', 'utils/canvas'], function($, _, Backbone, PointView, utils) {
    var AppView;
    AppView = Backbone.View.extend({
      el: "#app-container",
      template: _.template($('#app-main-tmpl').html()),
      events: {
        "dblclick": "createNode"
      },
      initialize: function() {
        this.render();
        this.collection.on('change remove add', (function(_this) {
          return function() {
            return _this.drawBezier();
          };
        })(this));
        return this.collection.on('add', (function(_this) {
          return function(point) {
            return _this.$el.append(_this.addPoint(point).$el);
          };
        })(this));
      },
      render: function() {
        var len;
        this.$el.html(this.template());
        this.grid = this.$('#grid');
        this.gridCtx = this.grid[0].getContext('2d');
        utils.drawGrid(this.gridCtx);
        this.canvas = this.$('#bezier');
        this.canvasCtx = this.canvas[0].getContext('2d');
        len = this.collection.length;
        this.collection.each((function(_this) {
          return function(point, i) {
            if (!(i === len - 1)) {
              utils.drawLine(_this.canvasCtx, point.toJSON(), _this.collection.at(i + 1).toJSON());
            }
            return _this.$el.append(_this.addPoint(point).$el);
          };
        })(this));
        return this.drawBezier();
      },
      addPoint: function(point) {
        return new PointView({
          model: point
        });
      },
      drawBezier: function() {
        return utils.drawBezierCurve(this.canvasCtx, this.collection.toJSON());
      },
      createNode: function(e) {
        var offset;
        if (e.target && e.target.classList.contains('bezierPoint')) {

        } else {
          if (1 || confirm("Create node?")) {
            offset = this.$el.offset();
            return this.collection.add({
              x: e.clientX - offset.left,
              y: e.clientY - offset.top
            });
          }
        }
      }
    });
    return AppView;
  });

}).call(this);
