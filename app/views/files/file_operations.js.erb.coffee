#on click to "Save" send ajax request to controller save this file method
$(document).on 'click', "#save_file", (e) ->
  e.preventDefault

  if $(@).parent().parent().parent('div').length
    id = $(@).parent().parent().parent().attr('id').substring(4)
  else
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

  if $(@).parent().parent().parent('div').length
    id = $(@).parent().parent().parent().attr('id').substring(4)
  else
    id = $(@).parent().parent().parent().find('a')[0].className.substring(4)
  $.get '/file/close_file', {id: id}, null, 'script'

  return false

#on click to "Close all" send ajax request to controller close all files method and show responce in modal window
$(document).on 'click', "#close_all_files", (e) ->
  e.preventDefault
  $.get '/file/close_all_files', null, ->
    $("#files ul").empty()
    $("#files .tab-content").empty()
  return false

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

#cut text from editor
$(document).on 'click', '#cut', (e) ->
  e.preventDefault
  id = $('.active').find('a')[0].className.substring(4)
  tmp = ace.edit("file_text#{id}")
  selection = tmp.getSelectionRange()
  txt = tmp.session.getTextRange(selection)
  if prompt 'Для копирования текста нажмите Ctrl+X и Enter', txt
    tmp.remove(selection)
  return false

#copy text from editor
$(document).on 'click', '#copy', (e) ->
  e.preventDefault
  id = $('.active').find('a')[0].className.substring(4)
  tmp = ace.edit("file_text#{id}")
  selection = tmp.getSelectionRange()
  txt = tmp.session.getTextRange(selection)
  prompt 'Для копирования текста нажмите Ctrl+C и Enter', txt
  return false

#copy file path
$(document).on 'click', '#copy_path', (e) ->
  e.preventDefault
  txt = $('.active').find('a')[0].title
  prompt 'Для копирования текста нажмите Ctrl+C и Enter', txt
  return false

#paste text into editor
$(document).on 'click', '#paste', (e) ->
  e.preventDefault
  id = $('.active').find('a')[0].className.substring(4)
  tmp = ace.edit("file_text#{id}")
  txt = editor.session.getTextRange(editor.getSelectionRange() )
  alert 'this menu is not ready'
  return false

#select all text in editor
$(document).on 'click', '#select_all', (e) ->
  e.preventDefault
  id = $('.active').find('a')[0].className.substring(4)
  tmp = ace.edit("file_text#{id}")
  tmp.selectAll()
  $(@).parent().parent().parent().removeClass('open')
  return false

#unselect text in editor
$(document).on 'click', '#unselect', (e) ->
  e.preventDefault
  id = $('.active').find('a')[0].className.substring(4)
  tmp = ace.edit("file_text#{id}")
  tmp.clearSelection()
  $(@).parent().parent().parent().removeClass('open')
  return false

#find text in editor
$(document).on 'click', '#find', (e) ->
  e.preventDefault
  id = $('.active').find('a')[0].className.substring(4)
  tmp = ace.edit("file_text#{id}")
  tmp.execCommand('find')
  $(@).parent().parent().parent().removeClass('open')
  return false