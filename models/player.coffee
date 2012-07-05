class Player
  constructor: (attributes) ->
    @[key] = value for key, value of attributes
    @

module.exports = Player
