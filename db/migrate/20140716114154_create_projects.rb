class CreateProjects < ActiveRecord::Migration
  def change
    drop_table :projects if table_exists? :projects
    create_table :projects do |t|
      t.string :name
      t.string :title
      t.integer :user_id
      t.boolean :status
      t.string :project_url
      t.boolean :removed

      t.timestamps
    end
  end
end
