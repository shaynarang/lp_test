class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.belongs_to :section
      t.string :title

      t.timestamps
    end
  end
end
