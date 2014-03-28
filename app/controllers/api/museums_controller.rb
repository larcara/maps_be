# encoding: UTF-8
class API::MuseumsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_museum
  before_filter :allow_cross_domain_access
  def index
    respond_to do |format|
      format.json {render json: @museum}
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
      render json: @new_user
    else
      render json: {error:@new_user.errors}
    end
    rescue ActionController::ParameterMissing => e
      render json: {error: {missing_parameter: e}}
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
        render json: @new_user
      else
        render json: {error:@new_user.errors}
      end
    rescue ActionController::ParameterMissing => e
      render json: {error: {missing_parameter: e}}
    end
  end

  def getCatalogs
    catalogs=@museum.museum_fields.select("distinct form_name").to_a
    render json: catalogs

  end
  def createCatalog
    catalog=params[:catalog].presence
    @museum.initMuseum(catalog)
   getSections
  end

  def getMuseumData
    respond_to do |format|
      format.json {render json: @museum}
    end
  end
  def setMuseumData

  end
  def getSections
    catalog=params[:catalog].presence
    @sections=@museum.sections(catalog)
    respond_to do |format|
      format.json {render json: @sections}
    end

  end

  def getSectionDetail
    catalog=params[:catalog].presence
    section=params[:section].presence
    @errors="Specificare il nome della sezione tra #{@museum.sections(catalog)}" if section.blank?
    @fields=@museum.museum_fields.sections(section,catalog)
    respond_to do |format|
      format.json {render json: {error: @errors, data: @fields}}
    end
  end

  def setSectionName
    catalog=params[:catalog].presence
    section=params[:section].presence
    new_label=params[:new_label].presence
    if catalog.blank? || section.blank? ||new_label.blank?
      @errors={error: "parametri errati: #{params.inspect}"}
    else
      if success=@museum.museum_fields.sections(section,catalog).update_all(  section_label: new_label)
        @fields=@museum.museum_fields.sections(section,catalog)
      else
        @errors << @museum.errors.full_messages
      end
    end
    respond_to do |format|
      format.json {render  json: {error: @errors, data: @fields}}
    end
  end

  def createSection
    #toDO se il nome è di default da nascondere
    catalog=params[:catalog].presence
    section=params[:section].presence
    field=@museum.availables_custom_fields.first
    errors=[]
    errors << "non ci sono campi custom disponibili" if field.blank?
    errors << "il nome della sezione e' già utilizzato " if @museum.sections.flatten.include? (section)
    if errors.any?
      render json: {error: errors }
      return
    end

      @field=@museum.museum_fields.build(
          form_name: catalog, section_name: section, section_label: section , template_field_id:field.id , label:field.field_label,
              enabled: true, hidden: false, position: 1, mobile: true, open_data: true, mandatory: false, options: "", option_key: nil)


    if @field.save
      render json: {error: nil, data: @field}
    else
      render json: {error: @field.errors.full_messages}
    end

  end
  def deleteSection

  end

  def setFieldDetails
    catalog=params[:catalog].presence
    section=params[:section].presence
    field=params[:field].presence
    data=params[:data].presence

    if ![catalog,section,field,data].all?
      @errors="parametri errati specificare :catalog , :section , :field , :data"
    else
      @field=@museum.museum_fields.where(template_field_id: field).first
      data=params[:data]
      @field.update_attributes(data.permit(:label, :enabled, :hidden, :position,:mobile, :open_data, :mandatory,:options,:option_key))
      if !@field.save
        @errors << @field.errors.full_messages
      end
    end
    respond_to do |format|
      format.json {render json: [@field, @errors]}
    end
  end

  def saveCard
    @errors=[]
    data=params[:data] # {1: valore1, 2: valore2}
    id=params[:id]
    @card=@museum.cards.find_by_id(id)
    @card||=@museum.cards.build
    data.each do |k,v| # 1: valore1
      attribute=TemplateField.find(k)
      @card.update_attribute(attribute.field_name.downcase.to_sym, v)
    end
    if !@card.save
      @errors << @card.errors.full_messages
    end
    respond_to do |format|
      format.json {render json: [@card, @errors]}
    end

  end


  def authenticate_museum
    @museum=@user.museum
  end


end
