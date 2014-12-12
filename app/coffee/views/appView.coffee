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
        this.updateBezier()
      )

      this.collection.on('add', (point) =>
        this.$el.append this.addPoint(point).$el
      )

      utils.ctx = this.canvasCtx


    render: ->
      this.$el.html( this.template() )

      this.grid = this.$ '#grid'
      this.gridCtx = this.grid[0].getContext '2d'
      utils.drawGrid this.gridCtx

      this.canvas = this.$ '#bezier'
      this.canvasCtx = this.canvas[0].getContext '2d'

      len = this.collection.length
      this.collection.each( (point, i) =>
        this.$el.append this.addPoint(point).$el
      )
      this.updateBezier()


    addPoint: (point) ->
      new PointView { model: point }

    updateBezier: ->
      utils.points = this.collection.toJSON()
      utils.trigger 'update:curve'

    createNode: (e) ->
      if (e.target && e.target.classList.contains('bezierPoint') )
        return
      else
        offset = this.$el.offset()
        this.collection.add({
          x: e.clientX - offset.left
          y: e.clientY - offset.top
        })

  })

  return AppView
)