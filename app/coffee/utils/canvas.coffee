define([], ->
  colors = {
    8: '#324F69'
    7: '#E3B58D'
    6: '#C3E04C'
    5: '#A584AD'
    4: '#ccc'
    3: '#3BCC99'
    2: '#7744AA'
    1: '#AAAA3E'
    0: '#D12454'
  }

  utils = {

    drawBezierCurve: (ctx, points) ->
      if (this.timer) then clearInterval(this.timer)
      ctr = 0
      curve = []
      this.timer = setInterval( =>
        ctx.clearRect(0, 0, 800, 800)

        p = this.drawBezierPoint ctx, points, (ctr % 100) / 100

        # draw stable curve
        ctx.beginPath()
        ctx.lineWidth = 5
        ctx.strokeStyle = '#111'
        for p in curve
          ctx.lineTo(p.x, p.y)

        ctx.stroke()
        ctx.closePath()

        ctx.beginPath()
        ctx.arc(p.x, p.y, 5, 0, 2 * Math.PI)
        ctx.fillStyle = '#D12454'
        ctx.fill()
        ctx.closePath()

        if (ctr++ > 100) then ctr = 0

      , 40)

      for i in [0..100]
        curve.push this.drawBezierPoint(ctx, points, i/100, true)


    drawBezierPoint: (ctx, points, l, silent) ->
      if (points.length == 2)
        this.drawLine(ctx, points[0], points[1], 2) unless silent
        return this.getX(points[0], points[1], l)

      arr = []
      for num in [0..points.length-2]
        this.drawLine(ctx, points[num], points[num+1], points.length) unless silent
        p = this.getX(points[num], points[num+1], l)
        arr.push p
      return this.drawBezierPoint(ctx, arr, l)


    drawLine: (ctx, p1, p2, number) ->
      ctx.beginPath()
      ctx.lineWidth = 3
      if (number)
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

  return utils
)