class ChangeFieldToCards < ActiveRecord::Migration
  def up
    remove_column :cards, :bibliografia
    remove_column :cards, :studio
    remove_column :cards, :descrizione
    remove_column :cards, :stato_conservazione
    add_column :cards, :stato_conservazione, :text
    add_column :cards, :descrizione, :text
    add_column :cards, :bibliografia, :text
    add_column :cards, :studio, :text

  end
  def down
    remove_column :cards, :bibliografia
    remove_column :cards, :studio
    remove_column :cards, :descrizione
    remove_column :cards, :stato_conservazione
    add_column :cards, :stato_conservazione, :string
    add_column :cards, :descrizione, :string
    add_column :cards, :bibliografia, :string
    add_column :cards, :studio, :string

  end
end
