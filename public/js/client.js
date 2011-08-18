(function() {
  var socket;
  socket = io.connect("http://localhost");
  socket.on("msg", function(data) {
    return console.log(data);
  });
}).call(this);
