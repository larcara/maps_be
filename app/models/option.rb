# == Schema Information
#
# Table name: options
#
#  id         :integer          not null, primary key
#  museum_id  :integer
#  name       :string(255)
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Option < ActiveRecord::Base

  scope :museum_options ,  ->(museum_id) {where(museum_id: [nil,museum_id])}
  scope :generic_options ,  ->() {where(museum_id: [nil])}
end
