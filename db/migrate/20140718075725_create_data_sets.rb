class CreateDataSets < ActiveRecord::Migration
  def change
    create_table :data_sets do |t|
      t.string :name
      t.string :extension
      t.text :text
      t.integer :directory_id
      t.boolean :opened
      t.boolean :removed
      t.integer :project_id

      t.timestamps
    end
  end
end
