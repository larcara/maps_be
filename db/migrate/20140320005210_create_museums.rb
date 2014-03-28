class CreateMuseums < ActiveRecord::Migration
  def change
    create_table :museums do |t|
      t.string :museo_id
      t.string :name
      t.string :city
      t.string :address
      t.string :telephone
      t.string :logo
      t.string :website


      t.timestamps
    end
  end
end
