class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.integer :museum_id
      t.string :colore
      t.string :descrizione
      t.string :oggetto

      t.timestamps
    end
  end
end
