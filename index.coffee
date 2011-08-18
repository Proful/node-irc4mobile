static = require("node-static")
http = require("http")
irc = require ("irc")

file = new static.Server './public'

app = http.createServer (req,res) ->
  req.addListener 'end', () ->
    file.serve req,res

io  = require('socket.io').listen(app)

console.log "Server started listening on port 80..."
app.listen 80

io.sockets.on 'connection', (socket) ->

  console.log "Connection establishes...."
  client = new irc.Client 'localhost', 'ircbot', {
      debug: false,
      channels: ['#node.js']
  }

  client.addListener 'error',  (message) ->
    console.log 'ERROR: %s: %s', message.command, message.args.join(' ') 

  client.addListener 'message', (from, to, message) ->
    console.log from + " > " + message
    socket.emit 'msg', {from: from,message: message}

  client.join '#node.js'

