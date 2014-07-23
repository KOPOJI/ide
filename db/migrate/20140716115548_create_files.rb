class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.string :name
      t.string :extension
      t.text :text, limit: 4294967295
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
