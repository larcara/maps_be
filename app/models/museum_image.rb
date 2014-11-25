# == Schema Information
#
# Table name: museum_images
#
#  id                 :integer          not null, primary key
#  card_id            :integer
#  label              :string(255)
#  link               :string(255)
#  num_prog           :integer
#  tipologia          :string(255)
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class MuseumImage < ActiveRecord::Base

  has_attached_file :image #, :path => "public/card_images/:museo_id/:id_codscheda.:extension", url:"/card_images/:museo_id/:id_codscheda.:extension"


      ##, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
      #lambda { |attachment| { :thumb => (attachment.instance.boss? ? "300x300>" : "100x100>") } }

  do_not_validate_attachment_file_type :image
  belongs_to :card


  after_save :update_link

  #before_create :set_progressivo

  Paperclip.interpolates :museo_id do |image, style|
    image.instance.museo_id
  end

  Paperclip.interpolates :id_codscheda do |image, style|
    if image.instance.prog.to_i == 0
      "#{image.instance.id_codscheda}"
    else
      "#{image.instance.id_codscheda}_#{image.instance.prog}"
    end
  end


  def set_progressivo
    self.prog=card.museum_images.size - 1
  end
  def update_link
    self.update_column(:link, image.url) unless self.image.blank?
  end

  def museo_id
    card.museum.museo_id
  end
  def id_codscheda
    card.id_codscheda
  end

def self.reset_progressivo
  x=[]
  Card.limit(1000).each do |c|
    index=0
    c.museum_images.order(:id).each do |image|
      x << ["progressivo=#{index}", "path=#{image.image.to_s}"] if image.image
      #tmpid="0000000000#{image.id}"[-9..-1]
      #x << ["progressivo=#{index}", "path=#{tmpid[0..2]}/#{tmpid[3..5]}/#{tmpid[6..8]}"]
      index=index+1
    end
  end
  x
end
end
