class CreateValues < ActiveRecord::Migration
  def change
    create_table :values do |t|
      t.belongs_to :key
      t.string :content

      t.timestamps
    end
  end
end
