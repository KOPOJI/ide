class RenameProjectIdToDirectoryId < ActiveRecord::Migration
  def change
    rename_column :files, :project_id, :directory_id
  end
end
