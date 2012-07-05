Room = require('./../models/room');

game = (app) ->
  io = require('socket.io').listen app
  
  io.of('/game').on 'connection', (socket) ->
    joinedRoom = null
    socket.on 'join', (data) ->
      Room.getById data.roomId, (err, room) ->
        if err
          socket.emit 'joined',
            isOK: false
        else
          joinedRoom = room
          socket.join joinedRoom.id
          socket.emit 'joined',
            isOK: true
            userId: data.userId

          socket.broadcast.to(joinedRoom.id).emit 'joined',
            isOK: true
            userId:data.userId

    socket.on 'message', (data) ->
      if joinedRoom
        socket.broadcast.to(joinedRoom.id).json.send data

    socket.on 'leave', (data) ->
      if joinedRoom
#        Room.leaveRoom(joinedRoom, data.nickName)
        socket.broadcast.to(joinedRoom.id).emit 'leaved',
            userId:data.userId

        socket.leave joinedRoom.id

module.exports = game