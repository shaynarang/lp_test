class DropUploadsTable < ActiveRecord::Migration
  def up
    drop_table :uploads
  end

  def down
    create_table :uploads
  end
end
