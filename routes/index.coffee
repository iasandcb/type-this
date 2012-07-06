
Room = require '../models/room'
Player = require '../models/player'

index = (app) ->
  app.get '/', (req, res) ->
    unless req.session.username
      res.redirect '/auth'
      return
    Room.all (err, rooms) ->
      res.render 'index',
        title: 'Lobby'
        rooms: rooms

  app.post '/', (req, res) ->
    unless req.session.username
      res.redirect '/auth'
      return
    host = new Player
      name: req.session.username
      id: req.session.userid

    attributes =
      name: req.body.name
      host: host
      players: [host]
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
      alreadyJoined = false

      for player in room.players
        if player.id is req.session.userid
          alreadyJoined = true
          break

      unless alreadyJoined
        guest = new Player
          name: req.session.username
          id: req.session.userid
        room.players.push guest

      room.save () ->
        res.render 'game',
          title: 'Game'
          room: room
          userName: req.session.username
          userId: req.session.userid

  app.get '/auth', (req, res) ->
    res.render 'auth',
      title: 'Auth'

  app.post '/auth', (req, res) ->
    req.session.username = req.body.username
    req.session.userid = req.body.userid
    res.send 'ok'

  app.get '/backbone', (req, res) ->
    res.render 'backbone',
      title: 'Backbone'

module.exports = index