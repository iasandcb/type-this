redis = require('redis').createClient()

class Room
  constructor: (attributes) ->
    @[key] = value for key, value of attributes
    @setDefaults()
    @

  setDefaults: ->
    @generateId()

  generateId: ->
    if not @id and @name
      @id = @name.replace /\s/g, '-'

  @key: ->
    "Room:#{process.env.NODE_ENV}"

  @all: (callback) ->
    redis.hgetall Room.key(), (err, objects) ->
      rooms = []
      for key, value of objects
        room = new Room JSON.parse(value)
        rooms.push room
      callback null, rooms

  save: (callback) ->
    @generateId()
    redis.hset Room.key(), @id, JSON.stringify(@), (err, responseCode) =>
      callback null, @

module.exports = Room