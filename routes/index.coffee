
Room = require '../models/room'

index = (app) ->
  app.get '/', (req, res) ->
    Room.all (err, rooms) ->
      res.render 'index',
        title: 'Rooms'
        rooms: rooms

  app.post '/', (req, res) ->
    attributes =
      name: req.body.name
    room = new Room attributes
    room.save () ->
      res.redirect "/game/#{room.id}"

  app.get '/game/:id', (req, res) ->
    Room.getById req.params.id, (err, room) ->
      room.attendants = [] unless room.attendants
      req.session.username = "anonymous#{room.attendants.length}" unless req.session.username
      room.attendants.push req.session.username unless req.session.username in room.attendants
      room.save () ->
        res.render 'game',
          title: 'Room'
          room: room
          userName: req.session.username

  app.get '/auth', (req, res) ->
    res.render 'auth',
      title: 'Auth'

  app.post '/auth', (req, res) ->
    req.session.username = req.body.username
    res.send 'ok'

module.exports = index