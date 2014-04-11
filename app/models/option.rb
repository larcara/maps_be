class Option < ActiveRecord::Base

  scope :museum_options ,  ->(museum_id) {where(museum_id: [nil,museum_id])}
  scope :generic_options ,  ->() {where(museum_id: [nil])}
end
