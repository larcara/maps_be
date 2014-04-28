# encoding: UTF-8
class API::MuseumsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_museum
  before_filter :allow_cross_domain_access

  def index
    respond_to do |format|
      format.json {render json:  {error: nil, data: @museum.as_json(except: [:created_at, :updated_at])}}
    end
  end

  def createUser
    begin
    p=params.require(:user).permit(:email,:password,:role,:nome, :cognome, :titolo_di_studio, :facolta, :nascita_data, :nascita_luogo, :residenza_indirizzo, :residenza_citta, :telefono)
    email=p.require :email
    password=p.require :password
    role=p.require :role
    @new_user= @museum.users.build(email:email, password:password,role:role)
    if @new_user.save
      render json: {error: nil, data: @new_user}
    else
      render json: {error:@new_user.errors, data: @new_user.as_json(except: [:created_at, :updated_at])}
    end
    rescue ActionController::ParameterMissing => e
      render json: {error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def getUsers
    begin
      raise "utente non abilitato " unless @user.is_admin?
      @users= @museum.users
      render json: {error: nil, data: @users.as_json(except: [:created_at, :updated_at])}
    rescue ActionController::ParameterMissing => e
      render json: {error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def updateUser
    begin


      p=params.require(:user).permit(:id,:email,:password,:role,:nome, :cognome, :titolo_di_studio, :facolta, :nascita_data, :nascita_luogo, :residenza_indirizzo, :residenza_citta, :telefono)
      id=p.require :id

      password=p[:password].presence
      role=p[:role].presence

      @new_user= @museum.users.find(id)

      raise "utente non abilitato " unless @user.is_admin? ||  @new_user.id === @user.id

      @new_user.update_attributes(p)
      if @new_user.save
        render json: {error: nil, data: @new_user.as_json(except: [:created_at, :updated_at])}
      else
        render json: {error:@new_user.errors, data: @new_user.as_json(except: [:created_at, :updated_at])}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "l'id specificatonon è valido", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s.message}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.message, data: nil}
    end

  end
  def destroyUser
    begin
      p=params.require(:user).permit(:email,:confirm_email)
      email=p.require :email
      confirm_email=p.require :confirm_email
      raise "le email non coincidono" unless confirm_email.eql?(email)
      raise "utente non abilitato " unless @user.is_admin?

      @new_user= @museum.users.where(email:email).first

      if @new_user.destroy!
        render json: {error: nil, data: "utente #{email} eliminato"}
      else
        render json: {error:@new_user.errors.full_messages, data: nil}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def getCatalogs
    catalogs=@museum.museum_sections.select("distinct form_name").to_a
    render json: {error: nil, data: catalogs}

  end
  def createCatalog
    begin
      catalog=params[:catalog].presence
      @museum.initMuseum(catalog)
      getSections
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def getMuseumData
    begin
      render json: {error: nil, data: @museum.as_json(except: [:created_at, :updated_at])}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end
  end
  def setMuseumData
    begin
      data=params.require(:museum).permit(:museo_id,:name,:city,:address,:telephone,:logo,:website, :curatore, :edificio, :fax, :email, :orario, :descrizione)
      image=params.fetch :image, nil
      delete_image=params.fetch :delete_image, false

      raise "non è possibile specificare contemporaneamente logo ed effettuare l'upload di un immagine" if !image.blank? && !data[:logo].blank?


      @museum.attributes=data

      @museum.image=image if image

      if delete_image
        @museum.image=nil
        @museum.logo=data[:logo]
      end

      if @museum.save
        render json: {error: nil, data: @museum.as_json(except: [:created_at, :updated_at])}
      else
        render json: {error: @museum.errors.full_messages, data: @museum.as_json(except: [:created_at, :updated_at])}
      end


    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def getSections
    begin
      params.require(:catalog)
      catalog=params[:catalog].presence
      filter=params[:filter].presence

      @sections=@museum.sections(catalog)
      if filter
        @sections=@sections.search(filter).result()
      end

      render json: {error: nil, data: @sections.as_json(except: [:created_at, :updated_at])}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
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

  def updateSection
    begin
      catalog=params.require :catalog
      section=params.require :section
      data=params.require(:data).permit(:section_label, :visible, :position)
      @section=@museum.museum_sections.where(form_name: catalog, section_name: section).first
      raise "Sezione non disponibile nel catalogo indicato" if @section.blank?

      if @section.update_attributes(data)
        render  json: {error: nil, data: @section.as_json(except: [:created_at, :updated_at])}
      else
        render  json: {error: @section.errors.full_messages, data: @section.as_json(except: [:created_at, :updated_at])}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def createSection
    #toDO se il nome è di default da nascondere
    begin
      catalog=params.require :catalog
      section=params.require :section
      #field=@museum.availables_custom_fields.first

      #raise "non ci sono campi custom disponibili" if field.blank?
      raise "il nome della sezione e' già utilizzato " if @museum.sections(catalog).flatten.include? (section)
      @section=@museum.museum_sections.build(form_name: catalog, section_name: section, section_label: section, custom: true, visible:true)
      #@field=@section.museum_fields.build(template_field_id:field.id , label:field.field_label,enabled: true, hidden: false, position: 1, mobile: true, open_data: true, mandatory: false, options: "", option_key: nil, custom:true)
      if @section.save
        render json: {error: nil, data: section}
      else
        render json: {error: @section.errors.full_messages, data: section.as_json(except: [:created_at, :updated_at])}
      end

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def deleteSection
    begin
      catalog=params.require :catalog
      section=params.require :section
      @section=@museum.museum_sections.where(form_name: catalog, section_name: section).first
      raise "utente non abilitato " unless @user.is_admin?
      raise "è possibile eliminare solo sezioni custom" unless @section.is_custom?
      raise "è possibile eliminare solo sezioni vuote" if @section.museum_fields.count > 0
      if @section.destroy
        render json:{error: nil, data: "sezione eliminata con success"}
      else
        render json:{error: @section.errors.full_messages, data: @section.as_json(except: [:created_at, :updated_at])}
      end

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end
  end


  def addFieldToSection
    #toDO se il nome è di default da nascondere
    begin
      catalog=params.require :catalog
      section=params.require :section


      field=@museum.availables_custom_fields(catalog).first

      raise "non ci sono campi custom disponibili" if field.blank?
      @section=@museum.museum_sections.where(form_name: catalog, section_name: section).first
      raise "il nome della sezione non è definito " if @section.blank?


      position=params.fetch(:position, 1)
      options=params.fetch(:options, nil)
      option_key=params.fetch(:option_key, nil)
      field_label=params.fetch(:field_label, field.field_label)

      @field=@section.museum_fields.build(template_field_id:field.id , label:field_label,
                                          enabled: true, hidden: false, position: position, mobile: true, open_data: true,
                                          mandatory: false, options: options, option_key: option_key, custom: true)

      if @field.save
        render json: {error: nil, data: @field.as_json(except: [:created_at, :updated_at], include: :museum_section)}
      else
        render json: {error: @field.errors.full_messages, data: @field.as_json(except: [:created_at, :updated_at])}
      end

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def removeFieldFromSection
    #toDO se il nome è di default da nascondere
    begin
      catalog=params.require :catalog
      section=params.require :section
      field_id=params.require :field_id

      @field=@museum.museum_fields(catalog,section).custom_fields.where(id:field_id).first
      raise "l'utente non è abilitato " unless @user.is_admin?
      raise "il campo custom richiesto non esiste nella scheda specificata" if @field.blank?

      @field=@museum.fields.find(field_id)

      if @field.destroy
        render json: {error: nil, data: @field.as_json(except: [:created_at, :updated_at])}
      else
        render json: {error: @field.errors.full_messages, data: @field.as_json(except: [:created_at, :updated_at])}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "l'id specificatonon è valido", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def setFieldDetails
    begin
      catalog=params.require :catalog
      section=params.require :section
      field_id=params.require :field_id
      data=params.require :data
      @field=@museum.museum_fields(catalog).where(id: field_id).first
      raise "il campo richiesto non esiste nella scheda specificata" if @field.blank?
      data=params[:data]
      @field=@museum.fields.find(@field.id)
      @field.update_attributes(data.permit(:label, :enabled, :hidden, :position,:mobile, :open_data, :mandatory,:options,:option_key))
      if @field.save
        render json: {error: nil, data: @field.as_json(except: [:created_at, :updated_at])}
      else
        render json: {error: @field.errors.full_messages, data: @field.as_json(except: [:created_at, :updated_at])}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "l'id specificatonon è valido", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def getCard
    begin
      id_card=params.fetch(:id, nil)
      id_codscheda=params.fetch(:id_codscheda, nil)
      raise "e' necessario un id o un codice_scheda " if id_card.blank? && id_codscheda.blank?

      if id_card
        @card=@museum.cards.where(id:id_card)
      else
        @card=@museum.cards.where(id_codscheda: id_codscheda).first
      end
      raise "le chiavi di ricerca specificate non corrispondono ad alcuna scheda del museo" if @card.blank?

      render json: {error: nil, data: @card.as_json(include: :museum_images)}
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end

  end
  def findCard
    begin
      filter=params.require(:filter)
      if filter
        @cards=@museum.cards.search(filter).result()
      end
      if @cards
        render json: {error: nil, data: @cards.as_json(include: :museum_images)}
      else
        render json: {error: "nessuna scheda con i filtri indicati", data: nil}
      end

    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end

  end
  def saveCard
    begin
      data=params.require :data
      id=params.fetch :id, 0
      errors=[]
      @card=@museum.cards.find_by_id(id.to_i)
      @card||=@museum.cards.build
      data.each do |k,v| # nome_campo_db: valore1
        attribute="#{k.downcase.to_sym}=".to_sym
        if @card.respond_to?( attribute)
          @card.send(attribute, v)
        else
          errors << "il campo #{attribute} non esite"
        end
      end
      if @card.save
        render json: {error: errors, data: @card}
      else
        render json: {error: [errors, @card.errors.full_messages], data: @card}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def deleteCard
    begin
      id=params.require :id
      raise "utente non abilitato" unless @user.is_admin?
      @card=@museum.cards.find_by_id(id)
      raise "identificativo scheda non corretto o utente non abilitato" if @card.blank?

      if @card.destroy
        render json: {error: nil, data: "scheda #{id} cancellata correttamente"}
      else
        render json: {error: @card.errors.full_messages, data: @card}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def saveImage
    begin
      card_id=params.require :card_id

      image_data=params.require(:image_data).permit(:label, :link, :id, :tipologia)
      image_file=params.fetch :image_file, nil



      @card=@museum.cards.find(card_id)
      @image=@card.museum_images.find_by_id(image_data[:id])

      @image||=@card.museum_images.build(label: image_data[:label], tipologia: image_data[:tipologia])
      if image_file
        @image.image=image_file
      else
        @image.link=image_data[:link]
      end
      if @image.save
        render json: {error: nil, data: @image}
      else
        render json: {error: @image.errors.full_messages, data: @image}
      end


    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end





  def printCard

    Prawn::Document.generate("card.pdf") do

    end
  end
end
