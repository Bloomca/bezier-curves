define([
  'views/appView',
  'views/controlsView',
  'collections/points',
  'utils/canvas'
], (AppView, ControlsView, Points, utils) ->

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

  #controlsView = new ControlsView()

  utils.init()

)