class CreateDirectories < ActiveRecord::Migration
  def change
    drop_table :directories if table_exists? :directories
    create_table :directories do |t|
      t.string :name
      t.string :path
      t.integer :project_id
      t.integer :parent_id
      t.boolean :removed

      t.timestamps
    end
  end
end
