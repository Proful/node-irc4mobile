(function() {
  var socket;
  socket = io.connect("http://localhost");
  socket.on("msg", function(data) {
    var html, source, template;
    console.log(data);
    source = $("#msg-tmpl").html();
    console.log(source);
    source = source.replace(/\\n/g, "");
    template = Handlebars.compile(source);
    html = template(data);
    return $('#msgs').append(html);
  });
}).call(this);
