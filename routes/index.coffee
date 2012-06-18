
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
      res.redirect '/'

  app.get '/game/:id', (req, res) ->
    Room.getById req.params.id, (err, room) ->
      res.render 'game',
        title: 'Room'
        room: room

module.exports = index