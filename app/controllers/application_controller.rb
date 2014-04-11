class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session



  def allow_cross_domain_access
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Access-Control-Allow-Methods"] = "GET, PUT, POST, DELETE"
  end

  #before_filter :authenticate_user!

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    auth_token = params[:auth_token].presence
    @user       = auth_token && User.find_by_authentication_token(auth_token.to_s)

    if @user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in( @user)
      current_user=@user
    else
      render json: { success: false, message: "Error with token #{auth_token.to_s} login or password"}, status: :unauthorized
    end
  end
  def authenticate_museum
    @museum=@user.museum
  end
end
