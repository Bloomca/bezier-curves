(function() {
  define([], function() {
    var colors, utils;
    colors = {
      8: '#324F69',
      7: '#E3B58D',
      6: '#C3E04C',
      5: '#A584AD',
      4: '#ccc',
      3: '#3BCC99',
      2: '#7744AA',
      1: '#AAAA3E',
      0: '#D12454'
    };
    utils = {
      drawBezierCurve: function(ctx, points) {
        var ctr, curve, i, _i, _results;
        if (this.timer) {
          clearInterval(this.timer);
        }
        ctr = 0;
        curve = [];
        this.timer = setInterval((function(_this) {
          return function() {
            var p, _i, _len;
            ctx.clearRect(0, 0, 800, 800);
            p = _this.drawBezierPoint(ctx, points, (ctr % 100) / 100);
            ctx.beginPath();
            ctx.lineWidth = 5;
            ctx.strokeStyle = '#111';
            for (_i = 0, _len = curve.length; _i < _len; _i++) {
              p = curve[_i];
              ctx.lineTo(p.x, p.y);
            }
            ctx.stroke();
            ctx.closePath();
            ctx.beginPath();
            ctx.arc(p.x, p.y, 5, 0, 2 * Math.PI);
            ctx.fillStyle = '#D12454';
            ctx.fill();
            ctx.closePath();
            if (ctr++ > 100) {
              return ctr = 0;
            }
          };
        })(this), 40);
        _results = [];
        for (i = _i = 0; _i <= 100; i = ++_i) {
          _results.push(curve.push(this.drawBezierPoint(ctx, points, i / 100, true)));
        }
        return _results;
      },
      drawBezierPoint: function(ctx, points, l, silent) {
        var arr, num, p, _i, _ref;
        if (points.length === 2) {
          if (!silent) {
            this.drawLine(ctx, points[0], points[1], 2);
          }
          return this.getX(points[0], points[1], l);
        }
        arr = [];
        for (num = _i = 0, _ref = points.length - 2; 0 <= _ref ? _i <= _ref : _i >= _ref; num = 0 <= _ref ? ++_i : --_i) {
          if (!silent) {
            this.drawLine(ctx, points[num], points[num + 1], points.length);
          }
          p = this.getX(points[num], points[num + 1], l);
          arr.push(p);
        }
        return this.drawBezierPoint(ctx, arr, l);
      },
      drawLine: function(ctx, p1, p2, number) {
        ctx.beginPath();
        ctx.lineWidth = 3;
        if (number) {
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
    return utils;
  });

}).call(this);
