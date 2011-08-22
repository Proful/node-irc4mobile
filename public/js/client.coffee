socket = io.connect "http://localhost:5000"

socket.on "msg", (data) ->
  source = $("#msg-tmpl").html()
  source = source.replace(/\\n/g,"")
  template = Handlebars.compile(source)
  html = template(data)
  $('#msgs').prepend(html)
