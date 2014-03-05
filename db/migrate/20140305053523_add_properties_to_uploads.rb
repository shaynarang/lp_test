class AddPropertiesToUploads < ActiveRecord::Migration
  def change
    add_column :uploads, :properties, :hstore
  end
end
