
Room = require '../models/room'

index = (app) ->
  app.get '/', (req, res) ->
    Room.all (err, rooms) ->
      res.render 'index',
        title: 'Login'
        rooms: rooms

  app.post '/', (req, res) ->
    attributes =
      name: req.body.name
    room = new Room attributes
    room.save () ->
      res.redirect '/'

module.exports = index