class AddImageToMuseumImage < ActiveRecord::Migration
  def self.up
    add_attachment :museum_images, :image
    add_attachment :museums, :image
  end

  def self.down
    remove_attachment :museum_images, :image
    remove_attachment :museums, :image
  end
end
