class LivingMuseumUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # , :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable , #, :registerable,
         :recoverable, :rememberable, :trackable  #, :validatable

  has_many :living_museum_user_searches

  before_save :ensure_authentication_token

  def ensure_authentication_token
    if self.authentication_token.blank?
      self.authentication_token = generate_authentication_token #TODO - destroy after logout
    end
  end
  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
