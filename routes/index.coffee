
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
      attendants: [req.body.host]
    room = new Room attributes
    room.save () ->
      res.redirect "/game/#{room.id}"

  app.get '/game/:id', (req, res) ->
    console.log req.cookies
    Room.getById req.params.id, (err, room) ->
      room.attendants.push req.session.username
      console.log room.attendants
      res.render 'game',
        title: 'Room'
        room: room

  app.get '/auth', (req, res) ->
    console.log req.session.username
    res.render 'auth',
      title: 'Auth'

  app.post '/auth', (req, res) ->
    req.session.username = req.body.username
    console.log req.session.username
    res.send 'ok'

module.exports = index