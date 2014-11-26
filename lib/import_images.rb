def import_images(museuo_id)
  t0=Time.now
  m=Museum.where(museo_id: museuo_id).first
  return if m.nil?

  base_path="/user/maps/img_tmp/#{m.museo_id}/JPG"
  Dir.entries(base_path).each do |f|
    id_codscheda=f.scan(/(.*)\.(.*)$/)[0].first
    card=m.cards.where(id_codscheda: id_codscheda).first
    if card
      image=card.museum_images.first
      image||=card.museum_images.create
      if image.link.to_s.downcase.start_with? "http"
        Rails.logger.warn "#### IMPORT_IMAGES #{t0.to_s}: museum_image with external link =>  #{image.to_yaml}"
      end
      image.image = File.new("#{base_path}/f", "r")
      image.save
    end
  end
  base_path="/user/maps/img_tmp/#{m.museo_id}/TIFF"
  Dir.entries(base_path).each do |f|
    id_codscheda=f.scan(/(.*)\.(.*)$/)[0].first
    card=m.cards.where(id_codscheda: id_codscheda).first
    if card
      image=card.museum_images.first
      image||=card.museum_images.create
      if image.link.to_s.downcase.start_with? "http"
        Rails.logger.warn "#### IMPORT_IMAGES #{t0.to_s}: museum_image with external link =>  #{image.to_yaml}"
      end
      image.image = File.new("#{base_path}/f", "r")
      image.save
    end
  end



end