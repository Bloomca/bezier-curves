define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
  colors = {
    0: '#ccc'
    1: '#3BCC99'
    2: '#7744AA'
    3: '#AAAA3E'
    4: '#D12454'
    5: '#A584AD'
    6: '#C3E04C'
    7: '#E3B58D'
    8: '#324F69'
  }

  utils = {

    max: 40
    len: 0

    init: ->
      this.getBezierCurve()
      this.drawBezierCurve()
      this.on('drag:start', =>
#        this.curve = []
#        this.getBezierCurve()
        this.static = true
      )

      this.on('drag:stop', =>
        this.static = false
        this.curve = []
        this.getBezierCurve()
      )

      this.on('dragging', =>
        this.curve = []
        this.getBezierCurve()
      )

    points: []
    curve: []

    drawBezierCurve: () ->
      ctr = 0
      this.timer = setInterval( =>
        return unless (this.points.length || this.ctx || this.curve.length)
        this.len = this.points.length
        ctx = this.ctx
        ctx.clearRect(0, 0, 800, 800)

        circle = this.drawBezierPoint ctx, this.points, (ctr % 100) / 100, { static: this.static }

        # draw stable curve
        ctx.beginPath()
        ctx.lineWidth = 5
        ctx.strokeStyle = '#111'
        for p in this.curve
          ctx.lineTo(p.x, p.y)

        ctx.stroke()
        ctx.closePath()

        if (circle)
          ctx.beginPath()
          ctx.arc(circle.x, circle.y, 5, 0, 2 * Math.PI)
          ctx.fillStyle = '#D12454'
          ctx.fill()
          ctx.closePath()

        if (ctr++ > 100) then ctr = 0

      , 40)

    getBezierCurve: ->
      for i in [0..this.max]
        this.curve.push this.drawBezierPoint this.ctx, this.points, i/this.max, { silent: true }

    drawBezierPoint: (ctx, points, l, options = {} ) ->
      if (points.length == 2)
        this.drawLine(ctx, points[0], points[1], 2) unless options.silent
        return this.getX(points[0], points[1], l)

      arr = []
      for num in [0..points.length-2]
        this.drawLine(ctx, points[num], points[num+1], this.len - points.length) unless options.silent
        p = this.getX(points[num], points[num+1], l)
        arr.push p
      return this.drawBezierPoint(ctx, arr, l) unless options.static


    drawLine: (ctx, p1, p2, number) ->
      ctx.beginPath()
      ctx.lineWidth = 3
      if (number?)
        ctx.strokeStyle = colors[number]
        ctx.fillStyle = colors[number]
      ctx.arc(p1.x, p1.y, 5, 0, 2 * Math.PI)
      ctx.moveTo(p1.x, p1.y)
      ctx.lineTo(p2.x, p2.y)
      ctx.arc(p2.x, p2.y, 5, 0, 2 * Math.PI)
      ctx.fill()
      ctx.stroke()
      ctx.closePath()

    drawGrid: (ctx) ->
      ctx.beginPath()

      for num in [0.5..800] by 20
        ctx.moveTo(num, 0)
        ctx.lineTo(num, 800)
        ctx.moveTo(0, num)
        ctx.lineTo(800, num)

      ctx.strokeStyle = '#ccc'
      ctx.stroke()

    getX: (p1, p2, l) ->
      return {
        x: this.getPoint(p1.x, p2.x, l)
        y: this.getPoint(p1.y, p2.y, l)
      }

    getPoint: (x1, x2, l) ->
      p = x1 + (x2 - x1) * l
      return p

  }

  _.extend(utils, Backbone.Events)

  return utils
)