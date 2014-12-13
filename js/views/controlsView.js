(function() {
  define(['jquery', 'underscore', 'backbone', 'utils/canvas', 'jqueryui'], function($, _, Backbone, utils) {
    var ControlsView;
    ControlsView = Backbone.View.extend({
      el: '#app-controls',
      events: {
        "click .toggle-static": "toggleActive"
      },
      template: _.template($('#app-controls-tmpl').html()),
      initialize: function() {
        this.render();
        return this.$('#quantity').slider({
          step: 1,
          min: 5,
          max: 40,
          value: utils.max
        });
      },
      render: function() {
        console.log(123);
        return this.$el.html(this.template());
      },
      toggleActive: function() {
        return utils.active = !utils.active;
      }
    });
    return ControlsView;
  });

}).call(this);
