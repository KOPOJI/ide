class CreateDataSets < ActiveRecord::Migration
  def change
    create_table :data_sets do |t|
      t.string :name
      t.string :extension
      t.text :text
      t.integer :user_id
      t.integer :directory_id
      t.boolean :opened

      t.timestamps
    end
  end
end
