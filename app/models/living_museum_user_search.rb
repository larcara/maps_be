# == Schema Information
#
# Table name: living_museum_user_searches
#
#  id                    :integer          not null, primary key
#  living_museum_user_id :integer
#  q                     :string(255)
#  limit                 :integer
#  filter                :text
#  sql                   :text
#  card_ids              :text
#  public                :boolean
#  created_at            :datetime
#  updated_at            :datetime
#

class LivingMuseumUserSearch < ActiveRecord::Base
  belongs_to :living_museum_user

end
