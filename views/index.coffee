
h1 @title

p -> a href: '/auth', -> 'Facebook authentication'

form action: '/', method: 'POST', ->
  label for: 'name', 'Create a room'
  input type: 'text', id: 'name', name: 'name'
  input type: 'hidden', id: 'host', name: 'host'
  input type: 'submit', value: 'Submit'

ul ->
  for room in @rooms
    li ->
      span room.name
      button onclick: "location.href='/game/#{room.id}'", 'Join'