class AddProgressivoToMuseumImage < ActiveRecord::Migration
  def change
    add_column :museum_images, :prog, :integer
  end
end
