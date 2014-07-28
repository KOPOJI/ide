$ ->
  $(document).on 'click', '.left ul li a', (e) ->
    e.preventDefault()
    chld = $(@.children[0])
    if chld.hasClass('fa-folder-open')
      chld.removeClass('fa-folder-open').addClass('fa-folder')
      $(@).parent().children('ul').hide()
      chld.show()
    else
      chld.removeClass('fa-folder').addClass('fa-folder-open')
      $(@).parent().children('ul').show()