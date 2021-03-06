
/**
 * Module dependencies.
 */

var express = require('express');

var RedisStore = require('connect-redis')(express);

var app = module.exports = express.createServer();

require ('coffee-script');

// Configuration

app.configure(function(){
  app.set('views', __dirname + '/views');
  app.set('view engine', 'jade');
  app.use(express.bodyParser());
  app.use(express.methodOverride());
  app.use(express.cookieParser());
  app.use(express.session({
        secret: "bdfajfkasjdfkjalkfjsakljdfkasj",
        store: new RedisStore
  }));
  app.use(app.router);
  app.use(express.static(__dirname + '/public'));
});

app.configure('development', function(){
  app.use(express.errorHandler({ dumpExceptions: true, showStack: true }));
});

app.configure('production', function(){
  app.use(express.errorHandler());
});

// Routes

require('./routes/index')(app);
require('./routes/game')(app);

app.listen(3000, function(){
  console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);
});
