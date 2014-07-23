$ ->
  $('.file<%= id %>').parent().remove()
  $('#file<%= id %>').parent().remove()
  $('#files ul li').removeClass('active')
  $('#files ul li').first().addClass('active')
  $('#files .tab-pane').children().removeClass('active')
  $('#files .tab-pane').hide()
  $('#files .tab-pane').first().show()