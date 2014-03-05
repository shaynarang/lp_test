class IndexUploadsProperties < ActiveRecord::Migration
  def up
    execute "CREATE INDEX uploads_properties ON uploads USING GIN(properties)"
  end

  def down
    execute "DROP INDEX uploads_properties"
  end
end
