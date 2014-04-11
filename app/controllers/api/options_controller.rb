# encoding: UTF-8
class API::OptionsController < ApplicationController
  before_filter :authenticate_user_from_token!
  before_filter :authenticate_museum
  before_filter :allow_cross_domain_access

  def index
    begin
      filter=params.require(:filter)
      if @museum
        @options=Option.museum_options(@museum.id).search(filter).result()
      else
        @options=Option.generic_options().search(filter).result()
      end
      render json: {error: nil, data: @options}
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e, data: nil}
    end
  end

  def create
    begin
      option_data=params.require(:option).permit(:name, :key, :value)
      @option=Option.new(option_data)
      @option.museum_id=@museum.id if @museum
      if @option.save
        render json: {error: nil, data: @option}
      else
        render json: {error: @option.errors.full_messages, data: @option}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.messare, data: nil}
    end
  end

  def update
    begin
      option_id=params.require(:id)
      option_data=params.require(:option).permit(:name, :key, :value)
      if @museum
        @option=Option.museum_options(@museum.id).find(option_id)
      else
        @option=Option.generic_options().find(option_id)
      end

      if @option.update_attributes(option_data)
        render json: {error: nil, data: @option}
      else
        render json: {error: @option.errors.full_messages, data: @option}
      end
    rescue ActiveRecord::RecordNotFound => e
      render json:{error: "per il museo corrente non esiste nessuna scheda con la chiave richiesta", data: nil}
    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end
  def destroy
    begin
      option_id=params.require(:id)
      raise "utente non abilitato" unless @user.is_admin?
      if @museum
        @option=Option.museum_options(@museum.id).find(option_id)
      else
        @option=Option.generic_options().find(option_id)
      end
      raise "identificativo scheda non corretto o museo non abilitato" if @option.blank?

      if @option.destroy
        render json: {error: nil, data: "option #{option_id} cancellata correttamente"}
      else
        render json: {error: @option.errors.full_messages, data: @option}
      end


    rescue ActionController::ParameterMissing => e
      render json:{error: {missing_parameter: e.to_s}, data: nil}
    rescue RuntimeError => e
      render json:{error: e.message, data: nil}
    end
  end


end
