class CreateKeyValuePairs < ActiveRecord::Migration
  def change
    create_table :key_value_pairs do |t|
      t.belongs_to :section
      t.hstore :pair

      t.timestamps
    end
  end
end
