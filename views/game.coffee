
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

#    game.on 'joined', (data) ->
#      if data.isOK

    game.on 'message', (data) ->
      attendants = $('#attendants')[0]
      for attendant in attendants.childNodes
        attendantName = attendant.textContent
        if attendantName is data.userName
          attendant.textContent = "#{attendantName} typed #{data.msg} in #{data.lapse} milliseconds"

    game.on 'leaved', (data) ->
      alert(data.userName + ' leaved')

    started = false
    startedTime = null

    $('#message').keypress ->
      if started
        return
      else
        started = true
        startedTime = new Date()

    $('form').submit (e) ->
      e.preventDefault()
      msg = messageBox.val()
      if $.trim(msg) isnt ''
        lapse = new Date().getTime() - startedTime.getTime()
        game.json.send
          userName: userName
          msg: msg
          lapse: lapse

        attendants = $('#attendants')[0]
        for attendant in attendants.childNodes
          attendantName = attendant.textContent
          if attendantName is userName
            attendant.textContent = "#{userName} typed #{msg} in #{lapse} milliseconds"

        started = false

        messageBox.val ''

    $('#leave').click (e) ->
      game.emit 'leave',
        userName: userName

      location.href = '/'

h1 @title

p id: 'facebook-name'

p ->
  span '#roomId', -> @room.id

p ->
  span '#userName', -> @userName

p 'Attendants'

ul '#attendants', ->
  li attendant for attendant in @room.attendants

form ->
  input '#message', type: 'text'

p 'Message', ->
  span id: 'hostMessage'
  span id: 'lapse'
