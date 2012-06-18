Room = require('./../models/room');

game = (app) ->
  io = require('socket.io').listen app
  
  io.of('/game').on 'connection', (socket) ->
    joinedRoom = null
    socket.on 'join', (data) ->
      if Room.hasRoom(data.roomName)
        joinedRoom = data.roomName
        socket.join joinedRoom
        socket.emit 'joined',
          isSuccess:true
          nickName:data.nickName

        socket.broadcast.to(joinedRoom).emit 'joined',
            isSuccess:true
            nickName:data.nickName

        Room.joinRoom joinedRoom, data.nickName
      else
        socket.emit 'joined',
          isSuccess:false

    socket.on 'message', (data) ->
      if joinedRoom
        socket.broadcast.to(joinedRoom).json.send data

    socket.on 'leave', (data) ->
      if joinedRoom
        Room.leaveRoom(joinedRoom, data.nickName)
        socket.broadcast.to(joinedRoom).emit 'leaved',
            nickName:data.nickName

        socket.leave joinedRoom

module.exports = game