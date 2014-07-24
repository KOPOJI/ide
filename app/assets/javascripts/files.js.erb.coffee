$ ->

  if $("#files ul li").length
    #show first tab
    $("#files ul li a:first").tab('show')
    $(".tab-pane").first().show()

  #on tab click hide old tabs and show current
  $('#files ul li a').click (e) ->
    e.preventDefault()
    $("#files .tab-pane").children().removeClass('active')
    $("#files .tab-pane").hide()
    $(this).tab('show')
    $("#" + @.className).parent().show()
    $("#file" + $(@).attr('data-id')).show()