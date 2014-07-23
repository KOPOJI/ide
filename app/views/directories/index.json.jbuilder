json.array!(@directories) do |directory|
  json.extract! directory, :id, :name, :path, :project_id
  json.url directory_url(directory, format: :json)
end
