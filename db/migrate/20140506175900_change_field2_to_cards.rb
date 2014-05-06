class ChangeField2ToCards < ActiveRecord::Migration
  def up

    remove_column :cards, :descrizione
    remove_column :cards, :stato_conservazione
    add_column :cards, :stato_conservazione, :text
    add_column :cards, :descrizione, :text


  end
  def down

    remove_column :cards, :descrizione
    remove_column :cards, :stato_conservazione
    add_column :cards, :stato_conservazione, :string
    add_column :cards, :descrizione, :string


  end
end
