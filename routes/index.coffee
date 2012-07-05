
Room = require '../models/room'

index = (app) ->
  app.get '/', (req, res) ->
    unless req.session.username
      res.redirect '/auth'
      return
    Room.all (err, rooms) ->
      res.render 'index',
        title: 'Rooms'
        rooms: rooms

  app.post '/', (req, res) ->
    unless req.session.username
      res.redirect '/auth'
      return
    attributes =
      name: req.body.name
      host: req.session.username
      players: [req.session.username]
    room = new Room attributes
    room.save () ->
      res.redirect "/game/#{room.id}"

  app.get '/game/:id', (req, res) ->
    unless req.session.username
      res.redirect '/auth'
      return
    Room.getById req.params.id, (err, room) ->
#      room.players = [] unless room.players
#      req.session.username = "anonymous#{room.players.length}" unless req.session.username
      room.players.push req.session.username unless req.session.username in room.players
      console.log room.players
      room.save () ->
        res.render 'game',
          title: 'Game'
          room: room
          userName: req.session.username

  app.get '/auth', (req, res) ->
    res.render 'auth',
      title: 'Auth'

  app.post '/auth', (req, res) ->
    req.session.username = req.body.username
    res.send 'ok'

module.exports = index