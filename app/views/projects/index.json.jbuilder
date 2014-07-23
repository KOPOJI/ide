json.array!(@projects) do |project|
  json.extract! project, :id, :name, :title, :user_id, :status
  json.url project_url(project, format: :json)
end
