define([
  'jquery', 'underscore', 'backbone', 'jqueryui'
], ($, _, Backbone) ->

  PointView = Backbone.View.extend({

    className: "bezierPoint"

    events: {
      "dblclick": "removePoint"
    }

    initialize: () ->

      this.$el.draggable({
        containment: "parent"
        drag: ( =>
          time = Date.now()
          (evt, ui) =>
            if (Date.now() - time < 100)
              return
            else
              time = Date.now()
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
      if (confirm("Delete node?"))
        this.model.destroy()
        this.remove()

  })

)