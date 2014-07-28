$ ->

  if $("#files ul li").length
    #show first tab
    $("#files ul li a:first").tab('show')
    $(".tab-pane").first().show()

  #on tab click hide old tabs and show current
  $(document).on 'click', '#files ul li a', (e) ->
    e.preventDefault()
    $("#files .tab-pane").children().removeClass('active')
    $("#files .tab-pane").hide()
    $(this).tab('show')
    $("#" + @.className).parent().show()
    $("#file" + $(@).attr('data-id')).show()

  $(document).on 'dblclick', '.list-files a', (e) ->
    id = $(@).attr("data-id")

    if($(".file#{id}").length == 1)
      $('#files ul li').removeClass('active')
      $(".file#{id}").parent().addClass('active')
      $('#files .tab-pane').children().removeClass('active')
      $('#files .tab-pane').hide()
      $(".file#{id}").tab('show')
      $("#file#{id}").parent().show()
      return false
    else
      $.get '/file/open_file', {id: id}, ->
        $('#files ul li').removeClass('active')
        $(".file#{id}").parent().addClass('active')
        $('#files .tab-pane').children().removeClass('active')
        $('#files .tab-pane').hide()
        $(".file#{id}").tab('show')
        $("#file#{id}").parent().show()
      , 'script'
    return false