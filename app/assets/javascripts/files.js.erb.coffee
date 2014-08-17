$ ->
  if $("#files ul li").length
    #show first tab
    $("#files ul li a:first").tab('show')
    $(".tab-pane").first().show()

  #close tab on click 'x'
  $(document).on 'click', '#files ul li a .close_tab', (e) ->
    e.preventDefault
    $.get '/file/close_file', {id: $(@).attr('data-id')}, null, 'script'
    return false

  #on tab click hide old tabs and show current
  $(document).on 'click', '#files ul li a', (e) ->
    e.preventDefault()
    $("#files .tab-pane").children().removeClass('active')
    $("#files .tab-pane").hide()
    $(this).tab('show')
    $("#" + @.className).parent().show()
    $("#file" + $(@).attr('data-id')).show()

  #open file on link dblclick
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

  tree = $('#tree').fancytree
    source: [
      title: $('#tree').attr('name'), key: $('#tree').attr('data-id'), folder: true, lazy: true
    ]
    lazyload: (event, data) ->
      node = data.node
      data.result = {
        url: 'directories/getTree'
        data:
          id: node.key
          title: node.title
      }
    extensions: ['dnd'],
    autoCollapse: true
    dnd:
      autoExpandMS: 400,
      focusOnClick: true,
      preventVoidMoves: true,
      preventRecursiveMoves: true,
      dragStart: (node, data) ->
        return true;
      dragEnter: (node, data) ->
        return true;
      dragDrop: (node, data) ->
        data.otherNode.moveTo(node, data.hitMode)

  $("#tree").contextmenu
    delegate: 'span.fancytree-title',
    menu: [
      {title: "<%= I18n.t('new') %>", children: [
        {title: "<%= I18n.t('new_dir') %>", cmd: 'new_dir', uiIcon: 'ui-icon-folder-collapsed', disabled: false}
        {title: "<%= I18n.t('new_file') %>", cmd: 'new_file', uiIcon: 'ui-icon-document', disabled: false}
        {title: "<%= I18n.t('new_file_from_template') %>", cmd: 'new_file_from_template', uiIcon: 'ui-icon-suitcase', disabled: false}
      ]}
        {title: "<%= I18n.t('rename') %>", cmd: 'rename', uiIcon: 'ui-icon-pencil', disabled: false}
        {title: "<%= I18n.t('delete') %>", cmd: 'delete', uiIcon: 'ui-icon-trash', disabled: false}
      {title: '----', disabled: false}
      {title: "<%= I18n.t('edit') %>", children: [
        {title: "<%= I18n.t('cut') %>", cmd: 'cut', uiIcon: 'ui-icon-scissors', disabled: false}
        {title: "<%= I18n.t('copy') %>", cmd: 'copy', uiIcon: 'ui-icon-copy', disabled: false}
        {title: "<%= I18n.t('paste') %>", cmd: 'paste', uiIcon: 'ui-icon-clipboard', disabled: false}
      ]}
    ],
    beforeOpen: (event, ui) ->
      node = $.ui.fancytree.getNode(ui.target);
      if node.extraClasses == 'header'
        $("#tree").contextmenu("enableEntry", "paste", false)
      node.setFocus()
      node.setActive()
    select: (event, ui) ->
      node = $.ui.fancytree.getNode(ui.target)
      switch ui.cmd
        when 'cut'
          $.post 'projects/setSession', {id: node.data.id, type: 'cut'}, ->
            ui.target.css('color', '#CCC')

        when 'copy'
          null
        when 'paste'
          null
        when 'new_file'
          null
        when 'new_file_from_template'
          null
        when 'new_dir'
          null
        when 'rename'
          null
        when 'remove'
          null