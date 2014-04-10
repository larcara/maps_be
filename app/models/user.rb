# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  role                   :string(255)
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string(255)
#  last_sign_in_ip        :string(255)
#  authentication_token   :string(255)
#  museum_id              :integer
#  created_at             :datetime
#  updated_at             :datetime
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable :registerable,, :validatable


  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable

  before_save :ensure_authentication_token

  validates_inclusion_of :role, in: ['amministratore','operatore','operatore_base'], allow_nil: true
  validates_uniqueness_of :email

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
