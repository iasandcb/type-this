
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
        players = $('#players')
        alreadyEnlisted = false
        for player in players[0].childNodes
          playerName = player.textContent
          if playerName is data.userName
            alreadyEnlisted = true
            break

        players.append $("<li>").attr("id", "player-" + data.userName).text(data.userName) unless alreadyEnlisted


    game.on 'message', (data) ->
      players = $('#players')[0]
      for player in players.childNodes
        playerName = player.textContent
        if playerName is data.userName
          player.textContent = "#{playerName} typed #{data.msg} in #{data.lapse} milliseconds"

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

        players = $('#players')[0]
        for player in players.childNodes
          playerName = player.textContent
          if playerName is userName
            player.textContent = "#{userName} typed #{msg} in #{lapse} milliseconds"

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

p 'players'

ul '#players', ->
  li player for player in @room.players

form ->
  input '#message', type: 'text'

p 'Message', ->
  span id: 'hostMessage'
  span id: 'lapse'
