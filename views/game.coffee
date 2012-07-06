
coffeescript ->
  $(document).ready ->
    game = io.connect('/game')
    userName = $('#userName').text()
    userId = $('#userId').text()
    hostId = $('#hostId').text()
    roomId = $('#roomId').text()
    messageBox = $('#message')
    hostLapse = null
    hostText = null

    game.on 'connect', ->
      game.emit 'join',
        roomId: roomId
        userId: userId
        userName: userName

    displayPlayerScore = (data) ->
      result = 'lost'
      if data.userId is hostId
        hostLapse = data.lapse
        hostText = data.msg
        result = ''
      else
        if hostText
          if hostText is data.msg
            if hostLapse > data.lapse
              result = 'won'

          hostText = null

      players = $('#players')[0]
      for player in players.childNodes
        if player.id is 'player-' + data.userId
          #playScore = $('<span/>')
          #.attr('id', 'playerScore').text("#{data.userName} typed #{data.msg} in #{data.lapse} milliseconds")
          $('#' + player.id).append "<br/><span> typed #{data.msg} in #{data.lapse} milliseconds. #{result}</span>"
          break

    game.on 'joined', (data) ->
      if data.isOK
        players = $('#players')
        alreadyEnlisted = false
        for player in players[0].childNodes
          if player.id is 'player-' + data.userId
            alreadyEnlisted = true
            break

        players.append $("<li id='player-#{data.userId}'><span>#{data.userName}</span></li>") unless alreadyEnlisted


    game.on 'message', (data) ->
      displayPlayerScore(data)

    game.on 'leaved', (data) ->
      alert(data.userId + ' leaved')

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
          userId: userId
          msg: msg
          lapse: lapse
        }
        game.json.send data

        displayPlayerScore(data)
        started = false

        messageBox.val ''

    $('#leave').click (e) ->
      game.emit 'leave',
        userId: userId

      location.href = '/'

h1 @title

p id: 'facebook-name'

p ->
  span 'Room name: '
  span '#roomId', -> @room.id

p ->
  span 'User name: '
  span '#userName', -> @userName

  span
    id: 'userId'
    style: 'display:none;'
    , -> @userId

p ->
  span 'Host name: '
  span  '#hostName', -> @room.host.name

  span
    id: 'hostId'
    style: 'display:none;'
    , -> @room.host.id

p 'players'

ul '#players', ->
  for player in @room.players
    li id: "player-#{player.id}", ->
      span player.name

form ->
  input '#message', type: 'text'
