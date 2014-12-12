define([
  'jquery', 'underscore', 'backbone', 'utils/canvas', 'jqueryui'
], ($, _, Backbone, utils) ->

  PointView = Backbone.View.extend({

    className: "bezierPoint"

    events: {
      "dblclick": "removePoint"
    }

    initialize: () ->

      this.$el.draggable({
        containment: "parent"
        start: =>
          utils.trigger "drag:start"
        stop: =>
          utils.trigger "drag:stop"
        drag: ( =>
          time = Date.now()
          (evt, ui) =>
            if (Date.now() - time < 20)
              return
            else
              time = Date.now()
              utils.trigger "dragging"
            p = ui.position
            this.model.set({
              x: p.left + 10
              y: p.top + 10
            })
        )()

      })

#      this.model.on('change', () =>
#        this.drawPoint()
#      )
      this.drawPoint()


    drawPoint: ->
      this.$el.css {
        left: this.model.get('x') - 10 + "px"
        top:  this.model.get('y') - 10 + "px"
      }

    removePoint: ->
      this.model.destroy()
      this.remove()

  })

)