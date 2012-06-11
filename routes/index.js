
/*
 * GET home page.
 */


var Room = require('../models/room');

exports.index = function(req, res){
  res.render('index', {
      title: 'Type This - Rooms '
      , rooms: Room.getAll()
  })
};