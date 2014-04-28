namespace :maps do
  desc "import da TabellaSchedeMaps"
  task :import => :environment do
    class Scheda < ActiveRecord::Base
      self.table_name="TabellaSchedeMaps"
    end
    Card.delete_all
    f=File.open("db/card.rb", "w")
    f.write("# encoding: UTF-8\r\n")
    Museum.all.each do |m|
    Scheda.where(idmuseo: m.museo_id).limit(1000).each do |s|
        attrs=s.attributes.dup

        attrs.delete("idmuseo")
        attrs[:id_codscheda]=attrs["idCodScheda"]
        attrs.delete("idCodScheda")
        attrs_final={}
        attrs.each do |k,v|
          attrs_final[k.to_s.downcase.to_sym]=v unless v.blank?
        end

        m.cards.create(attrs_final)
        attrs_final[:museum_id]= m.id
        f.write("Card.create(#{attrs_final})\r\n")

      end

    end
    f.close

  end
  desc "export da CARDS"
  task :export => :environment do
    f=File.open("db/card2.rb", "w")
    f.write("# encoding: UTF-8\r\n")
    Card.where("1=1").each do |s|
        attrs=s.attributes.dup
        attrs_final={}
        attrs.each do |k,v|
          attrs_final[k.to_s.downcase.to_sym]=v unless v.blank?
        end
        f.write("Card.create(#{attrs_final})\r\n")
      end

    f.close

  end

end