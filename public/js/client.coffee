socket = io.connect "http://localhost"

socket.on "msg", (data) ->
  console.log data
  source = $("#msg-tmpl").html()
  console.log source
  source = source.replace(/\\n/g,"")
  template = Handlebars.compile(source)
  html = template(data)
  $('#msgs').append(html)
