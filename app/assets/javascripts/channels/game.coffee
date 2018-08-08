App.game = App.cable.subscriptions.create "GameChannel",
  connected: ->
    @printMessage("Waiting for opponent...")
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  printMessage: (message) ->
    $("#messages").append("<p>#{message}</p>")
