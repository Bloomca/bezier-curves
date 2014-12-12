define(['models/point'], (Point) ->

  Points = Backbone.Collection.extend({
    model: Point
  })

  return Points

)