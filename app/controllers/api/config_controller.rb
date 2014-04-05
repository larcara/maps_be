class API::ConfigController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :allow_cross_domain_access
  def getSections
    @section=CardTemplateField.select(:section_name)
    render json: {error: nil, data: @section}
  end

  def getSectionFieldDetail
    begin

      section=params.require :section_name

      @fields=CardTemplateField.where(section_name: section)
      render   json: {error: nil, data: @fields}

    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e}, data: nil}
    rescue RuntimeError => e
      render json:{error: e, data: nil}
    end
  end
end
