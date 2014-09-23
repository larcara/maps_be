class API::LivingMuseumController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate_living_museum_user_from_token!, except: [:reset, :createUser, :requestResetPassword, :resetPassword]
  before_filter :allow_cross_domain_access


  def reset
    LivingMuseumUser.destroy_all
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
      @searches=LivingMuseumUserSearch.where(["living_museum_user_id = ? or public=true", @living_museum_user.id])

      raise "No search found" if @searches.blank?

      render json: {error: nil, data: @searches.as_json(except: [:living_museum_user_id, :sql, :created_at, :updated_at])}

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

  def exportCard
  end
end
