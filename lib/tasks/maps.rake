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
    Scheda.where(idmuseo: m.museo_id).each do |s|
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

  desc "genera xml open data - usage: rake genera_open_data "
  task :genera_open_data => :environment do
    include Rails.application.routes.url_helpers
    Rails.application.routes.default_url_options[:host]="digilab4.let.uniroma1.it:8080"
    Museum.all.each do |m|
      f=File.open("public/open_data/#{m.museo_id}.xml", "w")
      xml = Builder::XmlMarkup.new(target: f, :indent=>2)
      #def xml.inspect; target!; end
      #def xml.to_s; target!; end
      xml.instruct! :xml, :version=>"1.0", :encoding=>"ISO-8859-1"
      #xml.tag!('lido:lidoWrap', {"xmlns:lido"=>"http://www.lido-schema.org","xsi:schemaLocation"=>"http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd"}) do
      xml.tag!('lido:lidoWrap', {"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance",
                                 "xsi:schemaLocation"=>"http://www.lido-schema.org http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd",
                                 "xmlns:lido"=>"http://www.lido-schema.org"}) do
        m.cards.valide.each do |card|
          xml.tag!("lido:lido") do
            xml.tag!("lido:lidoRecID", {"lido:type"=>"local" , "lido:source"=>card.museum.name}, "PMS-#{card.museum.museo_id}/obj#{card.id_codscheda}")
            xml.lido :category
            xml.lido :descriptiveMetadata , nil, {"xml:lang" => "eng"} do
              xml.lido :objectClassificationWrap do
                xml.lido :objectWorkTypeWrap do
                  xml.lido( :objectWorkType) {xml.lido :term}
                end
                xml.lido :classificationWrap do
                  xml.lido( :classification , {lido:type="europeana:type"}) {xml.lido :term, "IMAGE"}
                end
              end
              xml.lido :objectIdentificationWrap do
                xml.lido :titleWrap do
                  xml.lido (:titleSet )  {xml.lido :appellationValue, {"xml:lang"=>"it",  "lido:pref"=>"preferred"}}
                end

                xml.lido :inscriptionsWrap

                xml.lido :repositoryWrap do
                  xml.lido :repositorySet, {"lido:type"=>"current"} do
                    xml.lido :repositoryName do
                      xml.lido :legalBodyName do
                        xml.lido :appellationValue, "#{card.oggetto}"
                      end
                    end
                  end
                end

                xml.lido :displayStateEditionWrap

                xml.lido :objectDescriptionWrap do
                  xml.lido :objectDescriptionSet do
                    xml.lido :descriptiveNoteValue, {"xml:lang"=>"it"}, "#{card.descrizione}"
                  end
                end
              end #end objectIdentificationWrap
            end # end descriptiveMetadata
            xml.lido :administrativeMetadata , nil, {"xml:lang" => "eng"} do
              xml.lido :rightsWorkWrap
              xml.lido :recordWrap do
                xml.lido :recordID, {"lido:type"=>"local"}
                xml.lido :recordType do
                  xml.lido :term, "single object"
                end
                xml.lido :recordSource do
                  xml.lido :legalBodyName do
                    xml.lido :appellationValue, "#{card.museum.name}"
                  end
                  xml.lido :legalBodyWeblink, "#{card.museum.website}"
                end
                xml.lido :recordInfoSet do
                  xml.lido :recordInfoLink, {"lido:formatResource"=>"html"}, "#{root_url(:only_path => false)}/api/living_museum/getCard?id=#{card.id}"
                end
              end

              xml.lido :resourceWrap do
                xml.lido :resourceSet do
                  xml.lido :resourceID, {"lido:type"=>"local"}
                  xml.lido :resourceRepresentation, {"lido:type"=>"image_thumb"} do
                    xml.lido :linkResource, {"lido:formatResource"=>"JPG"}, "#{card.image_link}"
                  end
                  xml.lido :rightsResource do
                    xml.lido :rightsType do
                      xml.lido :term, {"lido:pref"=>"http://www.europeana.eu/rights/rr-f"} do
                        xml.lido :term3
                      end
                    end
                    xml.lido :rightsHolder do
                      xml.lido :legalBodyID, {"lido:type"=>"URI", "lido:source"=>"ISIL (ISO 15511)"}, "info:isil/PMS-RMSMUS15"
                      xml.lido :legalBodyName do
                        xml.lido :appellationValue,  "#{card.museum.name}"
                      end
                      xml.lido :legalBodyWeblink,  "#{card.museum.website}"
                    end
                  end
                end
              end
            end #end administrativeMetadata
          end
        end
      end
      f.close
    end
   end


end