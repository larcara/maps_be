# == Schema Information
#
# Table name: museum_images
#
#  id                 :integer          not null, primary key
#  card_id            :integer
#  label              :string(255)
#  link               :string(255)
#  num_prog           :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class MuseumImage < ActiveRecord::Base

  has_attached_file :image #, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  do_not_validate_attachment_file_type :image
  belongs_to :card

  before_save :update_link

  def update_link
    self.link=image.url if image
  end
end
