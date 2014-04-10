# encoding: UTF-8
class API::MuseumsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_museum
  before_filter :allow_cross_domain_access

  def index
    respond_to do |format|
      format.json {render json:  {error: nil, data: @museum}}
    end
  end

  def createUser
    begin
    p=params.require(:user).permit(:email,:password,:role)
    email=p.require :email
    password=p.require :password
    role=p.require :role
    @new_user= @museum.users.build(email:email, password:password,role:role)
    if @new_user.save
      render json: {error: nil, data: @new_user}
    else
      render json: {error:@new_user.errors, data: @new_user}
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
      render json: {error: nil, data: @users}
    rescue ActionController::ParameterMissing => e
      render json: {error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def updateUser
    begin
      p=params.require(:user).permit(:email,:password,:role)
      email=p.require :email
      password=p[:password].presence
      role=p[:role].presence
      @new_user= @museum.users.where(email:email).first
      @new_user.update_attributes(p)
      if @new_user.save
        render json: {error: nil, data: @new_user}
      else
        render json: {error:@new_user.errors, data: @new_user}
      end
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
    catalogs=@museum.museum_fields.select("distinct form_name").to_a
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
      render json: {error: nil, data: @museum}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue  RuntimeError => e
      render json:{error: e.to_s, data: nil}
    end
  end
  def setMuseumData
    begin
      data=params.require(:museum).permit(:museo_id,:name,:city,:address,:telephone,:logo,:website)
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
        render json: {error: nil, data: @museum}
      else
        render json: {error: @museum.errors.full_messages, data: @museum}
      end


    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e, data: nil}
    end
  end

  def getSections
    begin
      params.require(:catalog)
      catalog=params[:catalog].presence
      @sections=@museum.sections(catalog)
      render json: {error: nil, data: @sections}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    end

  end
  def getSectionDetail
    begin
      catalog=params.require :catalog
      section=params.require :section
      @fields=@museum.section_fields(section,catalog)
      raise "Nessuna sezione con questi parametri" if @fields.blank?
      render json: {error: nil, data: @fields}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def setSectionName
    begin
      catalog=params.require :catalog
      section=params.require :section
      new_label=params.require :new_label
      @section=@museum.museum_sections.where(form_name: catalog, section_name: section).first
      raise "Sezione non disponibile nel catalogo indicato" if @section.blank?
      @section.section_label= new_label
      if @section.save
        render  json: {error: nil, data: @section}
      else
        render  json: {error: @section.errors.full_messages, data: @section}
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
      field=@museum.availables_custom_fields.first

      raise "non ci sono campi custom disponibili" if field.blank?
      raise "il nome della sezione e' già utilizzato " if @museum.sections(catalog).flatten.include? (section)
      @section=@museum.museum_sections.build(form_name: catalog, section_name: section, section_label: section, custom: true, visible:true)
      @field=@section.museum_fields.build(template_field_id:field.id , label:field.field_label,
                                          enabled: true, hidden: false, position: 1, mobile: true, open_data: true, mandatory: false, options: "", option_key: nil, custom:true)
      if @section.save
        render json: {error: nil, data: {section: section, field: @field}}
      else
        render json: {error: {section: @section.errors.full_messages,  field:@field.errors.full_messages}, data: {section: section, field: @field}}
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
        render json:{error: @section.errors.full_messages, data: @section}
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
      raise "il nome della sezione non è definito " unless @museum.sections(catalog).flatten.include? (section)

      @section=@museum.museum_sections.where(form_name: catalog, section_name: section).first

      position=params.fetch(:position, 1)
      options=params.fetch(:options, nil)
      option_key=params.fetch(:option_key, nil)
      field_label=params.fetch(:field_label, field.field_label)

      @field=@section.museum_fields.build(template_field_id:field.id , label:field_label,
                                          enabled: true, hidden: false, position: position, mobile: true, open_data: true,
                                          mandatory: false, options: options, option_key: option_key, custom: true)

      if @field.save
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
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

      @field=@museum.museum_fields(catalog,section).custom_fields.where(template_field_id:field_id).first
      raise "l'utente non è abilitato " unless @user.is_admin?
      raise "il campo custom richiesto non esiste nella scheda specificata" if @field.blank?


      if @field.destroy
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
      end

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
      @field=@museum.museum_fields(catalog).where(template_field_id: field_id).first
      raise "il campo richiesto non esiste nella scheda specificata" if @field.blank?
      data=params[:data]
      @field=MuseumField.find(@field.id)
      @field.update_attributes(data.permit(:label, :enabled, :hidden, :position,:mobile, :open_data, :mandatory,:options,:option_key))
      if @field.save
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
      end
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def getCard
    begin
      id=params.require(:id)
      @card=@museum.cards.find(id)

      render json: {error: nil, data: @card.as_json(include: :museum_images)}
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
      render json:{error: e, data: nil}
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
      image_id=params.fetch :image_id, 0
      label=params.require :label
      link=params.fetch :link, ""
      image=params.fetch :image, nil

      errors=[]

      @card=@museum.cards.find(card_id)
      @image=@card.museum_images.find_by_id(image_id)

      @image||=@card.museum_images.build(label: label)
      if image
        @image.image=image
        #data = StringIO.new(Base64.decode64(params[:account][:avatar][:data]))
        #data.class.class_eval { attr_accessor :original_filename, :content_type }
        #data.original_filename = params[:account][:avatar][:filename]
        #data.content_type = params[:account][:avatar][:content_type]
        #params[:account][:avatar] = data
      else
        @image.link=link
      end
      if @image.save
        render json: {error: errors, data: @image}
      else
        render json: {error: [errors, @image.errors.full_messages], data: @image}
      end


    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e, data: nil}
    end
  end


  def authenticate_museum
    @museum=@user.museum
  end


end
