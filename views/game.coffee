
coffeescript ->
  $(document).ready ->
    game = io.connect('/game')
    userName = $('#userName').text()
    roomId = $('#roomId').text()
    messageBox = $('#message')

    game.on 'connect', ->
      game.emit 'join',
        roomId: roomId
        userName: userName

    game.on 'joined', (data) ->
      if data.isOK
        alert(data.userName + ' joined')

    game.on 'message', (data) ->
      $('#hostMessage').text(data.msg)

    game.on 'leaved', (data) ->
      alert(data.userName + ' leaved')

    $('form').submit (e) ->
      e.preventDefault()
      msg = messageBox.val()
      if $.trim(msg) isnt ''
        game.json.send
          userName: userName
          msg: msg

        messageBox.val ''

    $('#leave').click (e) ->
      game.emit 'leave',
        userName: userName

      location.href = '/'

h1 @title

p id: 'facebook-name'

p 'Room name', ->
  span '#roomId', -> @room.id

p 'User', ->
  span '#userName', -> @userName

p 'Attendants'

ul ->
  li attendant for attendant in @room.attendants

form ->
  input '#message', type: 'text'
  input type: 'submit'

p 'Message', ->
  span id: 'hostMessage'
