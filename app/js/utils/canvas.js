(function() {
  define(['jquery', 'underscore', 'backbone'], function($, _, Backbone) {
    var colors, utils;
    colors = {
      0: '#ccc',
      1: '#3BCC99',
      2: '#7744AA',
      3: '#AAAA3E',
      4: '#D12454',
      5: '#A584AD',
      6: '#C3E04C',
      7: '#E3B58D',
      8: '#324F69'
    };
    utils = {
      max: 40,
      len: 0,
      init: function() {
        this.getBezierCurve();
        this.drawBezierCurve();
        this.on('drag:start', (function(_this) {
          return function() {
            return _this["static"] = true;
          };
        })(this));
        this.on('drag:stop', (function(_this) {
          return function() {
            _this["static"] = false;
            _this.curve = [];
            return _this.getBezierCurve();
          };
        })(this));
        return this.on('update:curve', (function(_this) {
          return function() {
            _this.curve = [];
            return _this.getBezierCurve();
          };
        })(this));
      },
      points: [],
      curve: [],
      drawBezierCurve: function() {
        var animate, ctr;
        ctr = 0;
        animate = (function(_this) {
          return function() {
            var circle, ctx, p, _i, _len, _ref;
            requestAnimationFrame(animate);
            if (!(_this.points.length || _this.ctx || _this.curve.length)) {
              return;
            }
            _this.len = _this.points.length;
            ctx = _this.ctx;
            ctx.clearRect(0, 0, 800, 800);
            circle = _this.drawBezierPoint(ctx, _this.points, (ctr % 100) / 100, {
              "static": _this["static"]
            });
            ctx.beginPath();
            ctx.lineWidth = 5;
            ctx.strokeStyle = '#111';
            _ref = _this.curve;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              p = _ref[_i];
              ctx.lineTo(p.x, p.y);
            }
            ctx.stroke();
            ctx.closePath();
            if (circle) {
              ctx.beginPath();
              ctx.arc(circle.x, circle.y, 5, 0, 2 * Math.PI);
              ctx.fillStyle = '#D12454';
              ctx.fill();
              ctx.closePath();
            }
            if (ctr++ > 100) {
              return ctr = 0;
            }
          };
        })(this);
        return requestAnimationFrame(animate);
      },
      getBezierCurve: function() {
        var i, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = this.max; 0 <= _ref ? _i <= _ref : _i >= _ref; i = 0 <= _ref ? ++_i : --_i) {
          _results.push(this.curve.push({
            x: this.getBezierFormula(this.max, i, i / this.max, 'x'),
            y: this.getBezierFormula(this.max, i, i / this.max, 'y')
          }));
        }
        return _results;
      },
      getBezierFormula: function(n, i, t, v) {
        var num, total, _i, _ref;
        total = 0;
        for (num = _i = 0, _ref = this.points.length; 0 <= _ref ? _i < _ref : _i > _ref; num = 0 <= _ref ? ++_i : --_i) {
          total += this.getBezierCoeff(this.points.length - 1, num, t, this.points[num][v]);
        }
        return total;
      },
      getBezierCoeff: function(n, i, t, v) {
        return this.getBinom(n, i) * Math.pow(1 - t, n - i) * Math.pow(t, i) * v;
      },
      getBinom: function(n, i) {
        return this.fact(n) / (this.fact(i) * this.fact(n - i));
      },
      fact: function(n) {
        if (n === 1 || n === 0) {
          return 1;
        }
        return n * this.fact(n - 1);
      },
      drawBezierPoint: function(ctx, points, l, options) {
        var arr, num, p, _i, _ref;
        if (options == null) {
          options = {};
        }
        if (points.length === 2) {
          if (!options.silent) {
            this.drawLine(ctx, points[0], points[1], 2);
          }
          return this.getX(points[0], points[1], l);
        }
        arr = [];
        for (num = _i = 0, _ref = points.length - 2; 0 <= _ref ? _i <= _ref : _i >= _ref; num = 0 <= _ref ? ++_i : --_i) {
          if (!options.silent) {
            this.drawLine(ctx, points[num], points[num + 1], this.len - points.length);
          }
          p = this.getX(points[num], points[num + 1], l);
          arr.push(p);
        }
        if (!options["static"]) {
          return this.drawBezierPoint(ctx, arr, l);
        }
      },
      drawLine: function(ctx, p1, p2, number) {
        ctx.beginPath();
        ctx.lineWidth = 3;
        if ((number != null)) {
          ctx.strokeStyle = colors[number];
          ctx.fillStyle = colors[number];
        }
        ctx.arc(p1.x, p1.y, 5, 0, 2 * Math.PI);
        ctx.moveTo(p1.x, p1.y);
        ctx.lineTo(p2.x, p2.y);
        ctx.arc(p2.x, p2.y, 5, 0, 2 * Math.PI);
        ctx.fill();
        ctx.stroke();
        return ctx.closePath();
      },
      drawGrid: function(ctx) {
        var num, _i;
        ctx.beginPath();
        for (num = _i = 0.5; _i <= 800; num = _i += 20) {
          ctx.moveTo(num, 0);
          ctx.lineTo(num, 800);
          ctx.moveTo(0, num);
          ctx.lineTo(800, num);
        }
        ctx.strokeStyle = '#ccc';
        return ctx.stroke();
      },
      getX: function(p1, p2, l) {
        return {
          x: this.getPoint(p1.x, p2.x, l),
          y: this.getPoint(p1.y, p2.y, l)
        };
      },
      getPoint: function(x1, x2, l) {
        var p;
        p = x1 + (x2 - x1) * l;
        return p;
      }
    };
    _.extend(utils, Backbone.Events);
    return utils;
  });

}).call(this);
