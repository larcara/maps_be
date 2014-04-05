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
    email=p[:email].presence
    password=p[:password].presence
    role=p[:role].presence
    @new_user= @museum.users.build(email:email, password:password,role:role)
    if @new_user.save
      render json: {error: nil, data: @new_user}
    else
      render json: {error:@new_user.errors, data: @new_user}
    end
    rescue ActionController::ParameterMissing => e
      render json: {error: {missing_parameter: e}, data: nil}
    end
  end

  def updateUser
    begin
      p=params.require(:user).permit(:email,:password,:role)
      email=p[:email].presence
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
      render json:{error: {missing_parameter: e}, data: nil}
    end
  end

  def destroyUser
    begin
      p=params.require(:user).permit(:email,:confirm_email)
      email=p[:email].presence
      confirm_email=p[:confirm_email].presence
      raise RuntimeError("le email non coincidono") unless confirm_email.equal?(email)
      raise RuntimeError("utente non abilitato ") unless @user.is_admin?
      @new_user= @museum.users.where(email:email).first

      if @new_user.destroy
        render json: {error: nil, data: "utente #{email} eliminato"}
      else
        render json: {error:@new_user.errors, data: nil}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
      rescue  RuntimeError => e
      render json:{error: e, data: nil}
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
      render json:{error: {missing_parameter: e}, data: nil}
    end
  end

  def getMuseumData
    begin
      render json: {error: nil, data: @museum}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    end
  end
  def setMuseumData

  end
  def getSections
    begin
      params.require(:catalog)
      catalog=params[:catalog].presence
      @sections=@museum.sections(catalog)
      render json: {error: nil, data: @sections}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
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
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def setSectionName
    begin
    catalog=params.require :catalog
    section=params.require :section
    new_label=params.require :new_label
    if success=@museum.museum_fields.sections(section,catalog).update_all(  section_label: new_label)
        @fields=@museum.museum_fields.sections(section,catalog)
    else
        @errors = @museum.errors.full_messages
    end
    render  json: {error: @errors, data: @fields}

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
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

      @field=@museum.museum_fields.build(
          form_name: catalog, section_name: section, section_label: section , template_field_id:field.id , label:field.field_label,
              enabled: true, hidden: false, position: 1, mobile: true, open_data: true, mandatory: false, options: "", option_key: nil)
      if @field.save
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
      end

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def addFieldToSection
    #toDO se il nome è di default da nascondere
    begin
      catalog=params.require :catalog
      section=params.require :section
      position=params.fetch(:position, 1)
      options=params.fetch(:options, "")
      option_key=params.fetch(:option_key, nil)

      field=@museum.availables_custom_fields.first
      raise "non ci sono campi custom disponibili" if field.blank?
      raise "il nome della sezione non è definito " unless @museum.sections(catalog).flatten.include? (section)

      @field=@museum.museum_fields.build(
          form_name: catalog, section_name: section, section_label: section , template_field_id:field.id , label:field.field_label,
          enabled: true, hidden: false, position: position, mobile: true, open_data: true, mandatory: false, options: options, option_key: option_key, custom:true)

      if @field.save
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
      end

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def deleteFieldFromSection
    #toDO se il nome è di default da nascondere
    begin
      catalog=params.require :catalog
      section=params.require :section
      field=params.require :section

      @field=@museum.museum_fields.custom_fields.where(section_name: section, template_field_id:field).first
      raise "il campo richiesto non esiste nella scheda specificata" if field.blank?
      raise "l'utente non è abilitato " unless @user.is_admin?


      if @field.destroy
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
      end

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def deleteSection
    begin
      catalog=params.require :catalog
      section=params.require :section
      render json:{error: nil, data: "funzione da implementare"}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e, data: nil}
    end
  end

  def setFieldDetails
    begin
      catalog=params.require :catalog
      section=params.require :section
      field=params.require :field
      data=params.require :data
      @field=@museum.museum_fields.where(template_field_id: field).first
      data=params[:data]
      @field.update_attributes(data.permit(:label, :enabled, :hidden, :position,:mobile, :open_data, :mandatory,:options,:option_key))
      if @field.save
        render json: {error: nil, data: @field}
      else
        render json: {error: @field.errors.full_messages, data: @field}
      end
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def saveCard
    begin
      data=params.require :data
      id=params.require :id
      @card=@museum.cards.find_by_id(id)
      @card||=@museum.cards.build
      data.each do |k,v| # 1: valore1
        attribute=TemplateField.find(k)
        @card.update_attribute(attribute.field_name.downcase.to_sym, v)
      end
      if @card.save
        render json: {error: nil, data: @card}
      else
        render json: {error: @card.errors.full_messages, data: @card}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
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
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end

  def authenticate_museum
    @museum=@user.museum
  end


end
