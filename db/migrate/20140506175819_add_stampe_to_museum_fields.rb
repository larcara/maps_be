class AddStampeToMuseumFields < ActiveRecord::Migration
  def change
    add_column :museum_fields, :stampa_a, :integer
    add_column :museum_fields, :stampa_b, :integer
    add_column :museum_fields, :stampa_c, :integer
  end
end
