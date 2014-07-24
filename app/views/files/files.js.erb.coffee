$ ->

  #on click at window remove this blocks
  $(document).mouseup (e) ->
    if(!$("#context").parent().is(e.target) && $("#context").parent().has(e.target).length == 0)
      $('#context').remove()
    if(!$("#directory_context").parent().is(e.target) && $("#directory_context").parent().has(e.target).length == 0)
      $('#directory_context').remove()

  #on click button "Esc" remove all context menu
  $(window).keyup (e) ->
    if e.keyCode == 27
      $('#context').remove()
      $('#directory_context').remove()

  #on menu on tabs show dialog
  $("#files ul li a").contextmenu (e) ->
    e.preventDefault
    $('#context').remove()

    $(@).parent().append("<%= j render 'files/dialog' %>")

    $("#context").offset({left: e.pageX + 5, top: e.pageY + 5})

    #on click to "Close" send ajax request to controller close this file method
    $("#close").click (e) ->
      e.preventDefault
      $.get '/file/close_file', {id: $(@).parent().parent().parent().find('a')[0].className.replace(/\D+/, '')}, null, 'script'
      return false

    #on click to "Close all" send ajax request to controller close all files method and show responce in modal window
    $("#close_all").click (e) ->
      e.preventDefault
      $.get '/file/close_all_files', null, ->
        $("#files ul").empty()
        $("#files .tab-content").empty()
      return false

    return false