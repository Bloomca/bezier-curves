require.config({
  paths: {
    "jquery": "../vendor/jquery-2.1.1"
    "underscore": "../vendor/underscore"
    "backbone": "../vendor/backbone"
    "jqueryui": "../vendor/jquery-ui.min"
  },
})

require(['app'], (App) ->
  console.log "app started"
)
