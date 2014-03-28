class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable,, :validatable


  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  before_save :ensure_authentication_token

  validates_inclusion_of :role, in: ['amministratore','operatore','operatore_base'], allow_nil: true

  belongs_to :museum

  def ensure_authentication_token
    if self.authentication_token.blank?
      self.authentication_token = generate_authentication_token
    end
  end

  def is_admin?
    role=='amministratore'
  end
  def is_operatore?
    return true if is_admin?
    role=='operatore'
  end
  def is_operatore_base?
    return true if is_admin?
    return true if is_operatore_base?
    role=='operatore_base'
  end

  private

  def generate_authentication_token
    loop do
      token = Devise.friendly_token
      break token unless User.where(authentication_token: token).first
    end
  end
end
