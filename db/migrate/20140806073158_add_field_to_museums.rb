class AddFieldToMuseums < ActiveRecord::Migration
  def change
    add_column :museums, :nome_direttore, :string
    add_column :museums, :staff, :text

  end
end
