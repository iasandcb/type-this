
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
          document.getElementById("facebook-name").innerHTML = me.name
          document.getElementById('host').value = me.name

h1 @title

p id: 'facebook-name'

p 'Create a room'
form action: '/', method: 'POST', ->
  label for: 'name', 'Room name'
  input type: 'text', id: 'name', name: 'name'
  input type: 'hidden', id: 'host', name: 'host'
  input type: 'submit', value: 'Submit'

ul ->
  for room in @rooms
    li ->
      p room.name
      input type:'button', value: 'Join', onclick: "location.href='/game/#{room.id}'"