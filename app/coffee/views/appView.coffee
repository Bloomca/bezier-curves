define([
  'jquery', 'underscore', 'backbone', 'views/pointView', 'utils/canvas'
], ($, _, Backbone, PointView, utils) ->
  AppView = Backbone.View.extend({

    el: "#app-container"

    template: _.template( $('#app-main-tmpl').html() )

    events: {
      "dblclick": "createNode"
    }

    initialize: ->
      this.render()

      this.collection.on('change remove add', =>
        this.drawBezier()
      )

      this.collection.on('add', (point) =>
        this.$el.append this.addPoint(point).$el
      )

    render: ->
      this.$el.html( this.template() )

      this.grid = this.$ '#grid'
      this.gridCtx = this.grid[0].getContext '2d'
      utils.drawGrid this.gridCtx

      this.canvas = this.$ '#bezier'
      this.canvasCtx = this.canvas[0].getContext '2d'

      len = this.collection.length
      this.collection.each( (point, i) =>
        unless (i == len-1)
          utils.drawLine(this.canvasCtx, point.toJSON(), this.collection.at(i+1).toJSON())
        this.$el.append this.addPoint(point).$el
      )
      this.drawBezier()


    addPoint: (point) ->
      new PointView { model: point }

    drawBezier: ->
      utils.drawBezierCurve(this.canvasCtx, this.collection.toJSON())

    createNode: (e) ->
      if (e.target && e.target.classList.contains('bezierPoint') )
        return
      else
        if (1 || confirm("Create node?"))
          offset = this.$el.offset()
          this.collection.add({
            x: e.clientX - offset.left
            y: e.clientY - offset.top
          })

  })

  return AppView
)