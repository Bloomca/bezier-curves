define([
  'jquery', 'underscore', 'backbone', 'utils/canvas', 'jqueryui'
], ($, _, Backbone, utils) ->

  ControlsView = Backbone.View.extend({

    el: '#app-controls'

    events: {
      "click .toggle-static": "toggleActive"
    }

    template: _.template $('#app-controls-tmpl').html()

    initialize: ->
      this.render()

      this.$('#quantity').slider {
        step: 1
        min: 5
        max: 40
        value: utils.max
      }

    render: ->
      console.log 123
      this.$el.html this.template()

    toggleActive: ->
      utils.active = !utils.active

  })

  return ControlsView

)