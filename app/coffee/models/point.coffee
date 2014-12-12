define([
  'jquery', 'underscore', 'backbone'
], ($, _, Backbone) ->

  Point = Backbone.Model.extend({
    defaults: {
      x: 100
      y: 100
    }
  })

  return Point
)