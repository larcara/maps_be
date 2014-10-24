class API::SessionsController < Devise::SessionsController
  before_filter :authenticate_user!, except: [:new, :create]
  before_filter :allow_cross_domain_access
  #before_filter :ensure_user_login_param_exists, only: [:create]
  #before_filter :ensure_email_param_exists, only: [:create]
  #before_filter :ensure_password_param_exists, only: [:create]
  respond_to :json

  def create
    resource = User.find_for_database_authentication(email: user_param[:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(user_param[:password])
      sign_in(:user, resource)
      resource.ensure_authentication_token
      render json: { success: true, auth_token: resource.authentication_token, email: resource.email }, status: :created
      return
    end
    invalid_login_attempt
  end

  def destroy
    current_user.reset_authentication_token
    render json: { success: true }, status: :ok
  end

  protected



  def user_param
    unless p=params.require(:user_login).permit(:email,:password)
      render json:{ success: false, message: "Missing :email,:password  parameter"}, status: :unprocessable_entity
    end
    p
  end

  def invalid_login_attempt
    render json: { success: false, message: "Error with your login or password"}, status: :unauthorized
  end
  private

  # For this example, we are simply using token authentication
  # via parameters. However, anyone could use Rails's token
  # authentication features to get the token from a header.
  def authenticate_user_from_token!
    user_token = params[:user_token].presence
    user       = user_token && User.find_by_authentication_token(user_token.to_s)

    if user
      # Notice we are passing store false, so the user is not
      # actually stored in the session and a token is needed
      # for every request. If you want the token to work as a
      # sign in token, you can simply remove store: false.
      sign_in user, store: false
    end
  end
end