class API::LivingMuseumRegistrationsController < Devise::RegistrationsController
  # Send confirmation instructions by email
  skip_before_filter :verify_authenticity_token
  respond_to :xml, :json
  def send_confirmation_instructions
    unless @raw_confirmation_token
      generate_confirmation_token!
    end

    opts = pending_reconfirmation? ? { to: unconfirmed_email } : { }
    opts[:url]="http://127.0.0.1"
    send_devise_notification(:confirmation_instructions, @raw_confirmation_token, opts)
  end


end