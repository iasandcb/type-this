
/*
 * GET home page.
 */


var Lobby = require('../models/lobby');

exports.index = function(req, res){
  res.render('index', {
      title: 'Type This - Lobby '
      , rooms: Lobby.getAllRooms()
  })
};