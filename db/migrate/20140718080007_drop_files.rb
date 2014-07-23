class DropFiles < ActiveRecord::Migration
  def change
    drop_table :files if table_exists? :files
  end
end
