socket = io.connect "http://localhost"

socket.on "msg", (data) ->
  console.log data
