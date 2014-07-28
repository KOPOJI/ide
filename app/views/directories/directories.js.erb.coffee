$ ->

  #set left block height (list of directories and files)
  $('.left').css('height', $(window).height() + 'px')

  #add our handler to mouse button click
  $(document).on 'contextmenu', '.directory', (e) ->
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

    #on click to "New dir" send ajax request to controller create directory method and show responce in modal window
    $(document).on 'click', "#new_dir", (e) ->
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
    $(document).on 'click', "#new_file", (e) ->
      e.preventDefault
      id = if $(@).parent().parent().attr("data-id") then $(@).parent().parent().attr("data-id") else $('.header').first().attr("data-id")
      $.get '/file/new_file', {id: id}, (ans) ->
        $("#modal-window").remove()
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    #on click to "Rename Directory" send ajax request to controller rename directory method and show responce in modal window
    $(document).on 'click', "#rename_dir", (e) ->
      e.preventDefault
      return unless $(@).parent().parent().attr("data-id")
      $.get '/directories/' + id + '/edit', null, (ans) ->
        $("#modal-window").remove()
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    #on click to "Remove Directory" send ajax request to controller remove directory method and show responce in modal window
    $(document).on 'click', "#remove_dir", (e) ->
      e.preventDefault
      return unless $(@).parent().parent().attr("data-id")
      if !confirm("<%= I18n.t 'Are you sure?' %>")
        return false
      $.ajax {
        url: '/directories/' + $(@).parent().parent().attr("data-id"),
        type: 'DELETE',
        data: 'id=' + $(@).parent().parent().attr("data-id")
        success: ->
          window.location.replace '/'
        }
      return false

    return false