$ ->

  $('#files ul li a').click (e) ->
    e.preventDefault()
    $("#files .tab-pane").children().removeClass('active')
    $("#files .tab-pane").hide()
    $(this).tab('show')
    $("#" + @.className).parent().show()
    $("#file" + $(@).attr('data-id')).show()

  $(window).click ->
    $('#context').remove()
  $("#files ul li a").contextmenu (e) ->
    e.preventDefault
    $('#context').remove()

    $(@).parent().append("<%= j render 'files/dialog' %>")

    $("#context").offset({left: e.pageX, top: e.pageY})

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