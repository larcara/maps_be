class ChangeFieldToCards < ActiveRecord::Migration
  def up
    remove_column :cards, :bibliografia
    remove_column :cards, :studio
    add_column :cards, :bibliografia, :text
    add_column :cards, :studio, :text

  end
  def down
    remove_column :cards, :bibliografia
    remove_column :cards, :studio
    add_column :cards, :bibliografia, :string
    add_column :cards, :studio, :string

  end
end
