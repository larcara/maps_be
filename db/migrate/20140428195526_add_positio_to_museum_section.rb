class AddPositioToMuseumSection < ActiveRecord::Migration
  def change
    add_column :museum_sections, :position, :integer
  end
end
