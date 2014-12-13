define(['jquery', 'underscore', 'backbone'], ($, _, Backbone) ->
  colors = {
    0: '#c1cdcd'
    1: '#7fffd4'
    2: '#8b7d6b'
    3: '#8b2323'
    4: '#7fff00'
    5: '#ff7256'
    6: '#00cdcd'
    7: '#ffb90f'
    8: '#9a32cd'
  }

  utils = {

    max: 40
    len: 0
    active: true

    init: ->
      this.getBezierCurve()
      this.drawBezierCurve()
      this.on('drag:start', =>
#        this.curve = []
#        this.getBezierCurve()
        this.static = true unless this.active
      )

      this.on('drag:stop', =>
        this.static = false
        this.curve = []
        this.getBezierCurve()
      )

      this.on('update:curve', =>
        this.curve = []
        this.getBezierCurve()
      )

    points: []
    curve: []

    drawBezierCurve: () ->
      ctr = 0

      animate = () =>
        requestAnimationFrame(animate)
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

      requestAnimationFrame(animate)


    getBezierCurve: ->
      for i in [0..this.max]
        this.curve.push {
          x: this.getBezierFormula(this.max, i, i/this.max, 'x')
          y: this.getBezierFormula(this.max, i, i/this.max, 'y')
        }

    getBezierFormula: (n, i, t, v) ->
      total = 0
      for num in [0...this.points.length]
        total += this.getBezierCoeff(this.points.length-1, num, t, this.points[num][v])
      return total

    getBezierCoeff: (n, i, t, v) ->
      this.getBinom(n, i) * Math.pow((1-t), n-i) * Math.pow(t, i) * v;

    getBinom: (n, i) ->
      this.fact(n) / ( this.fact(i) * this.fact(n-i) )

    fact: (n) ->
      return 1 if (n == 1 || n == 0)
      n * this.fact (n - 1)

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

      for num in [0.5...800] by 20
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