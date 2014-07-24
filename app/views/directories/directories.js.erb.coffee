$ ->

  #set left block height (list of directories and files)
  $('.left').css('height', $(window).height() + 'px')

  #add our handler to mouse button click
  $('.directory').contextmenu (e) ->
    $('#context').remove()
    $('#directory_context').remove()

    if -1 != @.className.indexOf('header')
      $(@).parent().append("<%= j render('directories/dialog', is_root: true) %>")
    else
      $(@).parent().append("<%= j render('directories/dialog', is_root: false) %>")

    #set id of parent element
    #id = if $(@).parent().attr("data-id") then $(@).parent().attr("data-id") else null
    id = $(@).parent().attr("data-id") || null

    #and add id to our block
    $("#directory_context").attr("data-id", id)
    $("#directory_context").offset({left: e.pageX + 10, top: e.pageY - 5})


    #$(window).click -> $("#directory_context").remove()

    #on click to "New dir" send ajax request to controller create directory method and show responce in modal window
    $("#new_dir").click (e) ->
      e.preventDefault
      $("#modal-window").remove()
      $.get '/directories/new', {id: $(@).parent().parent().attr("data-id")}, (ans) ->
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    #on click to "New File" send ajax request to controller create file method and show responce in modal window
    $("#new_file").click (e) ->
      e.preventDefault
      $.get '/file/new_file', {id: $(@).parent().parent().attr("data-id")}, (ans) ->
        $("#modal-window").remove()
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    #on click to "Rename Directory" send ajax request to controller rename directory method and show responce in modal window
    $("#rename_dir").click (e) ->
      e.preventDefault
      $.get '/directories/' + $(@).parent().parent().attr("data-id") + '/edit', null, (ans) ->
        $("#modal-window").remove()
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    return false