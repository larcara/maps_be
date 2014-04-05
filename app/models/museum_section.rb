class MuseumSection < ActiveRecord::Base
  belongs_to :museum
  has_many :museum_fields, dependent: :destroy

  scope :section , lambda {|section_name, form_name='default' | where(form_name: form_name,section_name: section_name)}
end
