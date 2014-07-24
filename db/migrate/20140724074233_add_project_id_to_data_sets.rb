class AddProjectIdToDataSets < ActiveRecord::Migration
  def change
    add_column :data_sets, :project_id, :integer
  end
end
