json.array!(@files) do |file|
  json.extract! file, :id, :name, :extension, :text, :user_id, :project_id
  json.url file_url(file, format: :json)
end
