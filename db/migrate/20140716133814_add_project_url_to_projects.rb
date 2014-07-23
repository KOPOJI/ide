class AddProjectUrlToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_url, :string
  end
end
