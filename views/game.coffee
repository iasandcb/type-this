
coffeescript ->
  window.fbAsyncInit = ->
    FB.init
      appId: "350109445062579"
      channelUrl: "//" + window.location.host + "/channel.txt"
      status: true
      cookie: true
      xfbml: true

    FB.Event.subscribe "auth.statusChange", (response) ->
      if response.authResponse
        FB.api "/me", (me) ->
          document.getElementById("facebook-name").innerHTML = me.name  if me.name

h1 @title

p id: 'facebook-name'

p "Room name: #{@room.name}"

p 'Attendants'

ul ->
  li attendant for attendant in @room.attendants
