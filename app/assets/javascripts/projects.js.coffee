$ ->

  #undo manager
  $(document).on 'click', '#undo', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    ace.edit("file_text#{id}").getSession().getUndoManager().undo(true)
    $(@).parent().parent().parent().removeClass('open')
    return false

  #redo manager
  $(document).on 'click', '#redo', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    ace.edit("file_text#{id}").getSession().getUndoManager().redo(true)
    $(@).parent().parent().parent().removeClass('open')
    return false

  $(document).on 'click', '#cut', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    tmp = ace.edit("file_text#{id}")
    selection = tmp.getSelectionRange()
    txt = tmp.session.getTextRange(selection)
    if prompt 'Для копирования текста нажмите Ctrl+X и Enter', txt
      tmp.remove(selection)
    return false

  $(document).on 'click', '#copy', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    tmp = ace.edit("file_text#{id}")
    selection = tmp.getSelectionRange()
    txt = tmp.session.getTextRange(selection)
    prompt 'Для копирования текста нажмите Ctrl+C и Enter', txt
    return false

  $(document).on 'click', '#copy_path', (e) ->
    e.preventDefault
    txt = $('.active').find('a')[0].title
    prompt 'Для копирования текста нажмите Ctrl+C и Enter', txt
    return false

  $(document).on 'click', '#paste', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    tmp = ace.edit("file_text#{id}")
    txt = editor.session.getTextRange(editor.getSelectionRange() )
    alert 'this menu is not ready'
    return false

  $(document).on 'click', '#select_all', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    tmp = ace.edit("file_text#{id}")
    tmp.selectAll()
    $(@).parent().parent().parent().removeClass('open')
    return false

  $(document).on 'click', '#unselect', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    tmp = ace.edit("file_text#{id}")
    tmp.clearSelection()
    $(@).parent().parent().parent().removeClass('open')
    return false

  $(document).on 'click', '#find', (e) ->
    e.preventDefault
    id = $('.active').find('a')[0].className.substring(4)
    tmp = ace.edit("file_text#{id}")
    tmp.execCommand('find')
    $(@).parent().parent().parent().removeClass('open')
    return false