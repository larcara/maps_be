class AddPubblicoToMuseumField < ActiveRecord::Migration
  def change
    add_column :museum_fields, :pubblico, :boolean
  end
end
