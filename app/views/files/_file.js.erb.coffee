$ ->
  $("#files ul").append(
    '<li><a class="file<%= file.id %>" href="#file<%= file.id %>" role="tab" data-toggle="tab" title="<%= create_url directory_path(file.directory), file.name %>">
    <%= file.name %>
    </a>
    </li>'
  )
  $("#files .tab-content").append(
    '<div class="tab-pane"><%= escape_javascript render(partial: "files/text", locals: {id: file.id}) %></div>'
  )
  $('#files ul li a').click (e) ->
    e.preventDefault()
    $("#files .tab-pane").children().removeClass('active')
    $("#files .tab-pane").hide()
    $(this).tab('show')
    $("#" + @.className).parent().show()
    $("#file" + $(@).attr('data-id')).show()

  $(window).click ->
    $('#context').remove()
  $("#files ul li a").contextmenu ->
    $('#context').remove()

    $(@).parent().append("<%= j render 'files/dialog' %>")

    $("#close").click (e) ->
      e.preventDefault
      $.get '/file/close_file', {id: $(@).parent().parent().parent().find('a')[0].className.replace(/\D+/, '')}, null, 'script'
      return false

    $("#close_all").click (e) ->
      e.preventDefault
      $.get '/file/close_all_files', null, ->
        $("#files ul").empty()
        $("#files .tab-content").empty()
      return false

    return false