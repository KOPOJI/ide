$ ->
  $("#files ul").append(
    '<li><a class="file<%= file.id %>" href="#file<%= file.id %>" role="tab" data-toggle="tab" title="<%= create_url directory_path(file.directory), file.name %>">
    <%= file.name %>
    </a>
    </li>'
  )
  $("#files .tab-content").append(
    '<div class="tab-pane"><%= escape_javascript render(partial: "files/text", locals: {id: file.id}) %></div>'
  )