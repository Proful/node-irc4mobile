(function() {
  var app, client, file, http, io, irc, msgReceived, socket, static;
  static = require("node-static");
  http = require("http");
  irc = require("irc");
  file = new static.Server('./public');
  app = http.createServer(function(req, res) {
    return req.addListener('end', function() {
      return file.serve(req, res);
    });
  });
  io = require('socket.io').listen(app);
  console.log("Server started listening on port 80...");
  app.listen(80);
  client = new irc.Client('localhost', 'butu5bot', {
    debug: false,
    channels: ['#node.js']
  });
  client.addListener('error', function(message) {
    return console.log('ERROR: %s: %s', message.command, message.args.join(' '));
  });
  /*
  client.addListener 'message', (from, to, message) ->
    console.log from + " > " + message
    socket.emit 'msg', {from: from,message: message}
  */
  socket = null;
  msgReceived = function(from, to, message) {
    if (socket != null) {
      socket.emit("msg", {
        from: from,
        message: message
      });
      return console.log("socket is not null");
    } else {
      return console.log("socket is null");
    }
  };
  client.addListener('message', msgReceived);
  io.sockets.on('connection', function(socket1) {
    return socket = socket1;
  });
}).call(this);
