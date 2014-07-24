$("#new_data_set").on 'ajax:success', (e, data, status, xhr) ->
  if xhr.responseText == 'created'
    $("#modal-window").remove()
    window.location.replace '/'
  else
    $("#modal-window").html(
        '<a id="closemodal" href="#" class="btn btn-primary close" data-dismiss="modal">Close</a>' + xhr.responseText
    )