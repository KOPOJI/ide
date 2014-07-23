class CreateDirectories < ActiveRecord::Migration
  def change
    drop_table :directories if table_exists? :directories
    create_table :directories do |t|
      t.string :name
      t.string :path
      t.integer :project_id

      t.timestamps
    end
  end
end
