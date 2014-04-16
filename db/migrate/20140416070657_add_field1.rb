class AddField1 < ActiveRecord::Migration
  def up
    add_column :users, :nome, :string
    add_column :users, :cognome, :string
    add_column :users, :titolo_di_studio, :string
    add_column :users, :facolta, :string
    add_column :users, :nascita_data, :date
    add_column :users, :nascita_luogo, :string
    add_column :users, :residenza_indirizzo, :string
    add_column :users, :residenza_citta, :string
    add_column :users, :telefono, :string
    add_column :museums, :curatore, :string
    add_column :museums, :edificio, :string
    add_column :museums, :fax, :string
    add_column :museums, :email, :string
    add_column :museums, :orario, :string
    add_column :museums, :descrizione, :string
  end
  def down
    remove_column :users, :nome
    remove_column :users, :cognome
    remove_column :users, :titolo_di_studio
    remove_column :users, :facolta
    remove_column :users, :nascita_data
    remove_column :users, :nascita_luogo
    remove_column :users, :residenza_indirizzo
    remove_column :users, :residenza_citta
    remove_column :users, :telefono
    remove_column :museums, :curatore
    remove_column :museums, :edificio
    remove_column :museums, :fax
    remove_column :museums, :email
    remove_column :museums, :orario
    remove_column :museums, :descrizione
  end
end
