class API::ConfigController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :allow_cross_domain_access
  def getSections
    @section=CardTemplateField.select(:section_name)
    respond_to do |format|
      format.json {render json: @section}
    end

  end

  def getFieldDetail
  end

  def getSectionFieldDetail
    @fields=CardTemplateField.where(section_name: params[:section_name])
    respond_to do |format|
      format.json {render json: @fields}
    end

  end
end
