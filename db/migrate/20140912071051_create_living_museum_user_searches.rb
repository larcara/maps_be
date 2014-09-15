class CreateLivingMuseumUserSearches < ActiveRecord::Migration
  def change
    create_table :living_museum_user_searches do |t|
      t.integer :living_museum_user_id
      t.string :q
      t.integer :limit
      t.text :filter

      t.text :sql
      t.text :card_ids
      t.boolean :public

      t.timestamps
    end
  end
end
