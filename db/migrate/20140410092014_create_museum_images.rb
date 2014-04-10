class CreateMuseumImages < ActiveRecord::Migration
  def change
    create_table :museum_images do |t|
      t.integer :card_id
      t.string :label
      t.string :link
      t.integer :num_prog

      t.timestamps
    end
  end
end
