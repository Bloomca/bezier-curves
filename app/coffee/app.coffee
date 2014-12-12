define([
  'views/appView',
  'collections/points',
  'utils/canvas'
], (AppView, Points, utils) ->

  points = new Points([{
    x: 100
    y: 100
  }, {
    x: 500
    y: 100
  }, {
    x: 100
    y: 500
  }, {
    x: 500
    y: 500
  }])

  appView = new AppView { collection: points }

  utils.init()

)