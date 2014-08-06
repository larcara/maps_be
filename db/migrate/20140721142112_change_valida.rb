class ChangeValida < ActiveRecord::Migration
  def up
    remove_column :cards, :valida
    add_column :cards, :valida, :boolean
    Card.update_all(valida: true)

  end
  def down
    remove_column :cards, :valida
    add_column :cards, :valida, :string
    Card.update_all(valida: "true")
  end
end
