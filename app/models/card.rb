# == Schema Information
#
# Table name: cards
#
#  id          :integer          not null, primary key
#  museum_id   :integer
#  colore      :string(255)
#  descrizione :string(255)
#  oggetto     :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Card < ActiveRecord::Base

  belongs_to :museum
end
