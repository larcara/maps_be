class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.integer :museum_id
      t.string :name
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
