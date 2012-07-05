
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

    displayPlayerScore = (data) ->
      players = $('#players')[0]
      for player in players.childNodes
        playerDetail = player.childNodes
        playerName = playerDetail[0].textContent
      #      playerName = player.textContent
        if playerName is data.userName
          #playScore = $('<span/>')
          #.attr('id', 'playerScore').text("#{data.userName} typed #{data.msg} in #{data.lapse} milliseconds")
          $('#' + player.id).append "<br/><span> typed #{data.msg} in #{data.lapse} milliseconds</span>"
          break

    game.on 'joined', (data) ->
      if data.isOK
        players = $('#players')
        alreadyEnlisted = false
        for player in players[0].childNodes
          playerDetail = player.childNodes
          playerName = playerDetail[0].textContent
          if playerName is data.userName
            alreadyEnlisted = true
            break

        players.append $("<li id='player-#{data.userName}'><span>#{data.userName}</span></li>") unless alreadyEnlisted


    game.on 'message', (data) ->
      displayPlayerScore(data)

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
        data = {
          userName: userName
          msg: msg
          lapse: lapse
        }
        game.json.send data

        displayPlayerScore(data)
        started = false

        messageBox.val ''

    $('#leave').click (e) ->
      game.emit 'leave',
        userName: userName

      location.href = '/'

h1 @title

p id: 'facebook-name'

p ->
  span 'Room name: '
  span '#roomId', -> @room.id

p ->
  span 'User name: '
  span '#userName', -> @userName

p 'players'

ul '#players', ->
  for player in @room.players
    li id: "player-#{player}", ->
      span player

form ->
  input '#message', type: 'text'
