xml.instruct! :xml, :version=>"1.0", :encoding=>"ISO-8859-1"
xml.tag!('lido:lidoWrap', {"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance",
                           "xsi:schemaLocation"=>"http://www.lido-schema.org http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd",
                           "xmlns:lido"=>"http://www.lido-schema.org"}) do
#xml.tag!('lido:lidoWrap', {"xmlns:lido"=>"http://www.lido-schema.org",
#                           "xsi:schemaLocation"=>"http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd"}) do
  @cards.each do |card|
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
            xml.lido :recordInfoLink, {"lido:formatResource"=>"html"},  "#{url_for(controller: :living_museum, action: :getCard, id:card.id, :only_path => false)}"
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
