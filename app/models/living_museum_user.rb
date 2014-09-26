# == Schema Information
#
# Table name: living_museum_users
#
#  id                     :integer          not null, primary key
#  first_name             :string(255)
#  last_name              :string(255)
#  user_name              :string(255)
#  authentication_token   :string(255)
#  created_at             :datetime
#  updated_at             :datetime
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
#  confirmation_token     :string(255)
#  confirmed_at           :datetime
#  confirmation_sent_at   :datetime
#  unconfirmed_email      :string(255)
#

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
