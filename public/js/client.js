(function() {
  var socket;
  socket = io.connect("http://localhost");
  socket.on("msg", function(data) {
    var html, source, template;
    source = $("#msg-tmpl").html();
    source = source.replace(/\\n/g, "");
    template = Handlebars.compile(source);
    html = template(data);
    return $('#msgs').prepend(html);
  });
}).call(this);
