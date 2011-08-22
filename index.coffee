static = require("node-static")
http = require("http")
irc = require ("irc")

file = new static.Server './public'

app = http.createServer (req,res) ->
  req.addListener 'end', () ->
    file.serve req,res

io  = require('socket.io').listen(app)

console.log "Server started listening on port 80..."
app.listen 5000

client = new irc.Client 'irc.freenode.net', 'pkbot', {
#client = new irc.Client 'localhost', 'pkbot', {
    debug: true,
    channels: ['#node.js']
}

client.addListener 'error',  (message) ->
  console.log 'ERROR: %s: %s', message.command, message.args.join(' ') 

# client.join '#node.js'

###
client.addListener 'message', (from, to, message) ->
  console.log from + " > " + message
  socket.emit 'msg', {from: from,message: message}
###
socket = null
msgReceived = (from, to, message) ->
  if socket?
    socket.emit "msg", {from: from, message: message}
    console.log "socket is not null"
  else
    console.log "socket is null"

client.addListener 'message', msgReceived

io.sockets.on 'connection', (socket1) ->
  socket = socket1
