$ ->
  `<%= raw(render template: 'files/file_operations.js.erb.coffee', locals: {cut: true}) %>`

  #on click at window remove this blocks
  $(document).mouseup (e) ->
    if(!$("#context").parent().is(e.target) && $("#context").parent().has(e.target).length == 0)
      $('#context').remove()
    if(!$("#directory_context").parent().is(e.target) && $("#directory_context").parent().has(e.target).length == 0)
      $('#directory_context').remove()
    if(!$("#editor_context").parent().is(e.target) && $("#editor_context").parent().has(e.target).length == 0)
      $('#editor_context').remove()

  #on click button "Esc" remove all context menu
  $(window).keyup (e) ->
    if e.keyCode == 27
      $('#context').remove()
      $('#directory_context').remove()
      $('#editor_context').remove()


  #open file on link dblclick
  $(document).on 'contextmenu', '.list-files a', (e) ->
    $('#context').remove()
    $('#directory_context').remove()
    $('#editor_context').remove()

    $(@).parent().append("<%= j render 'files/dialog', tab: false %>")

    $("#context").offset({left: e.pageX + 5, top: e.pageY + 5})
    return false

  $(document).on 'click', '#rename_file', (e) ->
    e.preventDefault
    id = $(@).parent().parent().parent().find('a').first().attr('data-id')
    $.get "/files/#{id}/edit", null, (ans) ->
      $("#modal-window").remove()
      $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
        '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>' +
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

  $(document).on 'contextmenu', '.code', (e) ->
    e.preventDefault
    $("#editor_context").remove()

    if ace.edit("file_text#{$('.active').find('a')[0].className.substring(4)}").getSelectionRange().isEmpty()
      $('body').append("<%= j render 'files/editor_dialog', cut: false %>")
    else
      $('body').append("<%= j render 'files/editor_dialog', cut: true  %>")

    $("#editor_context").offset({left: e.pageX + 5, top: e.pageY + 5})
    $(document).on 'contextmenu', '#editor_context', (e) ->
      e.preventDefault
      return false

    `<%= raw(render template: 'files/file_operations.js.erb.coffee', locals: {cut: false}) %>`

    return false

  #on menu on tabs show dialog
  $(document).on 'contextmenu', '#files ul li a', (e) ->
    e.preventDefault
    $('#context').remove()
    $('#directory_context').remove()

    $(@).parent().append("<%= j render 'files/dialog', tab: true %>")

    $("#context").offset({left: e.pageX + 5, top: e.pageY + 5})
    `<%= raw(render template: 'files/file_operations.js.erb.coffee', locals: {cut: false}) %>`

    return false