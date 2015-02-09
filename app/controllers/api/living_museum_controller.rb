class API::LivingMuseumController < ApplicationController
  include Rails.application.routes.url_helpers
  skip_before_filter :verify_authenticity_token

  before_filter :authenticate_living_museum_user_from_token!, except: [:reset, :createUser, :requestResetPassword, :resetPassword, :getCard]

  before_filter :allow_cross_domain_access


  def reset
    LivingMuseumUser.destroy_all if Rails.env.development?
    render json: {data: "reset ok"}
  end

  def createUser
    begin
      password=params.require(:password)
      email=params.require(:email)
      first_name=params.require(:first_name)
      last_name=params.require(:last_name)

      acct=LivingMuseumUser.new
      #password_token="test12345678"
      acct.password=password
      #acct.reset_password_token= password_token
      acct.email=email
      acct.last_name=last_name
      acct.first_name=first_name
      if acct.save
        #send mail...
        render json: {error: nil, data: acct}
      else
        render json: {error:acct.errors, data: acct.as_json(except: [:created_at, :updated_at])}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.messare, data: nil}
    end
  end

  def requestResetPassword
    begin
    email=params.require(:email)
    @living_museum_user = LivingMuseumUser.find_for_database_authentication(email:email)
    password_token=SecureRandom.uuid
    @living_museum_user.reset_password_token= password_token
    @living_museum_user.reset_password_sent_at = Time.now.utc

    if @living_museum_user.save
      puts "send mail... for token #{password_token}"
      render json: {error: nil, data: "email sent"}
    else
      render json: {error:@living_museum_user.errors.full_messages, data: acct.as_json(except: [:created_at, :updated_at])}
    end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.messare, data: nil}
    end
  end

  def resetPassword
    begin
      p=params.require(:living_museum_user).permit(:reset_password_token,:auth_token,:new_password)
      reset_password_token=p.require(:reset_password_token)
      auth_token=params.fetch :auth_token, nil
      new_password=p.require(:new_password)

      @living_museum_user = LivingMuseumUser.find_by_authentication_token(auth_token.to_s)


      if @living_museum_user && @living_museum_user.valid_password?(reset_password_token) #current user
        @living_museum_user.password=new_password
      else
        @living_museum_user=LivingMuseumUser.where(["reset_password_token = ? and reset_password_sent_at >?", reset_password_token, Time.now.advance(days: -1)]).first
        @living_museum_user.password=new_password

      end
      if @living_museum_user.save
        sign_in( @living_museum_user)
        current_user=@living_museum_user
        render json: {error: nil, data: @living_museum_user}
      else
        render json: {error: "Invalid Token", data: nil}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def deleteUser
  end

  def destroyUser
  end

  def searchCards
    begin
      query=params.require(:q)
      limit=params.fetch :limit, 50
      limit=limit.to_i
      filter={localita: nil, regione: nil, stato: nil, nazione: nil, epoca: nil, dt_assoluta: nil, museum_id: nil}
      filter_counter={localita: nil, regione: nil, stato: nil, nazione: nil, epoca: nil, dt_assoluta: nil, museum_id: nil}
      filter.each_key{|k| filter[k]=params.fetch k, nil}
      raise "Query too short  min 3 characthers " if query.size < 3

      raise "Query Limit max is 500 Cards " if limit > 500

      @cards=Card.valide
      filter.each do |k,v|
        @cards=@cards.where(k => v) unless v.blank?
      end
      @cards=@cards.search_by_full_text(query)


      #TODO - exctract keywords....
      filter_counter.each do |k,v|
        sql = @cards.to_sql
        sql =  sql.gsub(/(?<s>SELECT) .* (?<f>FROM .*) ORDER BY .*/, '\k<s> #{k} as value, count(*) as tot \k<f> group by #{k} order by count(*)')
        sql = sql.gsub!('#{k}', k.to_s)
        puts sql
        filter_counter[k]=Card.find_by_sql(sql).map{|x| [x.value, x.tot]}
      end

      @cards=@cards.limit(limit)
      if @cards
        render json: {error: nil, data: @cards.as_json(include: :museum_images), filter: filter_counter}
      else
        render json: {error: "nessuna scheda con i filtri indicati", data: nil}
      end


    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end



  end

  def saveSearch
    begin
      query=params.require(:q)
      is_public=params.require(:is_public)

      limit=params.fetch :limit, 50
      limit=limit.to_i
      filter={localita: nil, regione: nil, stato: nil, nazione: nil, epoca: nil, dt_assoluta: nil, museum_id: nil}
      filter_counter={localita: nil, regione: nil, stato: nil, nazione: nil, epoca: nil, dt_assoluta: nil, museum_id: nil}
      filter.each_key{|k| filter[k]=params.fetch k, nil}
      search_id=params.fetch :search_id, nil
      raise "Query too short  min 3 characthers " if query.size < 3
      raise "Query Limit max is 500 Cards " if limit > 500
      raise "is_public paramenter must be 0 (private) or 1 (public) instead is #{is_public.to_s}" unless ["0","1"].include? is_public.to_s

      @cards=Card.valide
      filter.each do |k,v|
        @cards=@cards.where(k => v) unless v.blank?
      end
      @cards=@cards.search_by_full_text(query)
      sql=@cards.to_sql
      if search_id
        @user_search=@living_museum_user.living_museum_user_searches.find(search_id.to_i)
      else
        @user_search=@living_museum_user.living_museum_user_searches.build()
      end
      @user_search.q= query
      @user_search.filter=filter.to_param
      @user_search.sql=sql
      @user_search.limit=limit
      @user_search.public= is_public.to_i

      if @user_search.save
        render json: {error: nil, data: {id: @user_search.id, is_public: @user_search.public}}
      else
        render json: {error: @user_search.errors.full_messages, data: nil}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end


  end

  def getSearch
    begin
      search_id=params.require(:search_id)
      @user_search=LivingMuseumUserSearch.find(search_id.to_i)

      if @user_search.public

      elsif @user_search.living_museum_user_id != @living_museum_user.id
        raise "User not authorized to access this query"
      end
      @user_search.touch
      render json: {error: nil, data: @user_search.as_json(except: [:living_museum_user_id, :sql, :created_at, :updated_at])}

    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end

  end

  def listSearch
    begin
      public_search_limit=params.fetch :public_search_limit, 10
      @my_searches=@living_museum_user.living_museum_user_searches
      @public_searches=LivingMuseumUserSearch.where(["living_museum_user_id <> ? and public=true", @living_museum_user.id]).order("updated_at desc").limit(public_search_limit)

      raise "No search found" if (@my_searches.blank? && @public_searches.blank?)

      render json: {error: nil, private: @my_searches.as_json(except: [:living_museum_user_id, :sql, :created_at, :updated_at]), public: @public_searches.as_json(except: [:living_museum_user_id, :sql, :created_at, :updated_at])}

    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def deleteSearch
    begin
      search_id=params.require(:search_id)
      @user_search=@living_museum_user.living_museum_user_searches.find(search_id.to_i)

      if @user_search.destroy
        render json: {error: nil, data: "Search deleted!"}
      else
        render json: {error: @user_search.errors.full_messages, data: nil}
      end

    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "record not found", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def exportCards
    begin
      card_ids=params.require :card_ids
      @cards=Card.find(card_ids)

      xml = Builder::XmlMarkup.new(:indent=>2)




      respond_to do |format|
        format.json {render json: {error: "the export is avaiable only in xml", data: nil}}# index.html.erb
        format.xml  # index.builder
      end

    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "alcune chiavi fornite non sono relative a schede valide", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end

  end

  def downloadLidoXml
    begin
      card_ids=params.require :card_ids
      @cards=Card.find(card_ids)

      final=""
      xml = Builder::XmlMarkup.new(target: final, :indent=>2)
      #def xml.inspect; target!; end
      #def xml.to_s; target!; end
      xml.instruct! :xml, :version=>"1.0", :encoding=>"ISO-8859-1"
      #xml.tag!('lido:lidoWrap', {"xmlns:lido"=>"http://www.lido-schema.org","xsi:schemaLocation"=>"http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd"}) do
      xml.tag!('lido:lidoWrap', {"xmlns:xsi"=>"http://www.w3.org/2001/XMLSchema-instance",
                                 "xsi:schemaLocation"=>"http://www.lido-schema.org http://www.lido-schema.org/schema/v1.0/lido-v1.0.xsd",
                                 "xmlns:lido"=>"http://www.lido-schema.org"}) do
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
                  xml.lido :recordInfoLink, {"lido:formatResource"=>"html"},  "http://digilab4.let.uniroma1.it:8080/interfacce/living/getCard.html?idcards=#{card.id}"
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



      send_data final, :type => 'text/xml; charset=UTF-8;', :disposition => 'attachment; filename=file.xml'




    return

    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end

  end

  def getCard
    begin
      id_card=params.require :id

      raise "e' necessario l'id " if id_card.blank?

      @card=Card.find(id_card)

      museum=@card.museum
      fields=museum.section_fields("*").where(pubblico: true)



      render json: {error: nil, data: @card.as_json(only: fields.map{|x| x.field_name.to_sym }, include: :museum_images), fields: fields}
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: " non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end

  end
  def getSectionDetail
    begin
      catalog=params.require :catalog
      section=params.require :section
      filter=params[:filter].presence

      @fields=@museum.section_fields(section,catalog)
      if filter
        @fields=@fields.search(filter).result()
      end

      raise "Nessuna sezione con questi parametri" if @fields.blank?
      render json: {error: nil, data: @fields.as_json(except: [:created_at, :updated_at], include: :museum_section)}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
end
