$ ->

  $('.left').css('height', $(window).height() + 'px')

  $("#files ul li a:first").tab('show')
  $(".tab-pane").first().show()

  $('.directory').contextmenu (e) ->
    $('#directory_context').remove()

    if -1 != @.className.indexOf('header')
      $(@).parent().append("<%= j render('directories/dialog', is_root: true) %>")
    else
      $(@).parent().append("<%= j render('directories/dialog', is_root: false) %>")

    id = if $(@).parent().attr("data-id") then $(@).parent().attr("data-id") else null
    $("#directory_context").attr("data-id", id)
    $("#directory_context").offset({left: e.pageX + 10, top: e.pageY - 5})

    $(window).click -> $("#directory_context").remove()

    $("#new_dir").click (e) ->
      e.preventDefault
      $.get '/directories/new', {id: $(@).parent().parent().attr("data-id")}, (ans) ->
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    $("#new_file").click (e) ->
      e.preventDefault
      $.get '/file/new_file', {id: $(@).parent().parent().attr("data-id")}, (ans) ->
        $('<div id="modal-window" class="modal hide fade" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">' +
            '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>'+
          '</div>')
            .append(ans)
            .modal('show')
      return false

    $("#close_all").click (e) ->
      e.preventDefault
      $.get '/file/close_all_files', null, ->
        $("#files ul").empty()
        $("#files .tab-content").empty()
      return false

    return false
#
#  elems = $("#files ul li")
#
#  for i in [1..elems.length]
#    el = $(elems[i]).find("a")[0]
#    if el && $("." + el.className).length > 1
#      $("#" + el.className).parent().remove()
#      $(el).parent().remove()
#  $("#files ul li a:first").tab('show')
#  $(".tab-pane").first().show()