class ChangeDtAssoluta < ActiveRecord::Migration
  def up
    remove_column :cards, :dt_assoluta
    add_column :cards, :dt_assoluta, :date
  end
  def down
    remove_column :cards, :dt_assoluta
    add_column :cards, :dt_assoluta, :string
  end

end
