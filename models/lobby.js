var Lobby = module.exports = {
  rooms: []
	, createRoom: function(roomName) {
    this.rooms.push({name:roomName, attendants:[]});
  }
  , getAllRooms: function() {
		return this.rooms.map(function(element) {
    	return element.name;
    });
  }
  , joinRoom: function(roomName, user) {
		var rooms = this.rooms.filter(function(element) {
			return (element.name === roomName);   
    });
    if (!this.hasAttendant(rooms[0].attendants, user)) {
    	rooms[0].attendants.push(user);
    }
  }
}