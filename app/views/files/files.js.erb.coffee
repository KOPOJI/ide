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


  #open file on link dblclick
  $(document).on 'contextmenu', '.list-files a', (e) ->
    $('#context').remove()
    $('#directory_context').remove()

    $(@).parent().append("<%= j render 'files/dialog', tab: false %>")

    $("#context").offset({left: e.pageX + 5, top: e.pageY + 5})
    return false

  $(document).on 'click', '#rename_file', (e) ->
    e.preventDefault
    id = $(@).parent().parent().parent().find('a').first().attr('data-id')
    $.get "/files/#{id}/edit", null, (ans) ->
      $("#modal-window").remove()
      $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
        '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
        '</div>')
      .append(ans)
      .modal('show')
    return false

  $(document).on 'click', '#remove_file', (e) ->
    e.preventDefault
    id = $(@).parent().parent().parent().find('a').first().attr('data-id')
    if !confirm("<%= I18n.t 'Are you sure?' %>")
      return false
    $.ajax {
      type: 'DELETE',
      url: '/files/' + id,
      data: "id=#{id}",
      success: (ans) ->
        window.location.replace '/'
    }
    return false

  #on menu on tabs show dialog
  $(document).on 'contextmenu', '#files ul li a', (e) ->
    e.preventDefault
    $('#context').remove()
    $('#directory_context').remove()

    $(@).parent().append("<%= j render 'files/dialog', tab: true %>")

    $("#context").offset({left: e.pageX + 5, top: e.pageY + 5})

    #on click to "Save" send ajax request to controller save this file method
    $(document).on 'click', "#save_file", (e) ->
      e.preventDefault
      id = $(@).parent().parent().parent().find('a')[0].className.substring(4)
      tmp = ace.edit("file_text" + id)
      $.get "/file/save_file", {id: id, text: tmp.getSession().getValue()}, (ans) ->
        $(".unsaved").remove()
        $("#context").remove()
        id = $('.active').find('a')[0].className.substring(4)
        $(".file#{id}").tab('show')
        $("#file#{id}").parent().show()

      return false

    #on click to "Close" send ajax request to controller close this file method
    $(document).on 'click', "#close_file", (e) ->
      e.preventDefault
      $.get '/file/close_file', {id: $(@).parent().parent().parent().find('a')[0].className.replace(/\D+/, '')}, null, 'script'
      return false

    #on click to "Close all" send ajax request to controller close all files method and show responce in modal window
    $(document).on 'click', "#close_all_files", (e) ->
      e.preventDefault
      $.get '/file/close_all_files', null, ->
        $("#files ul").empty()
        $("#files .tab-content").empty()
      return false

    return false