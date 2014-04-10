# == Schema Information
#
# Table name: museum_sections
#
#  id            :integer          not null, primary key
#  museum_id     :integer
#  form_name     :string(255)
#  section_name  :string(255)
#  section_label :string(255)
#  custom        :boolean
#  visible       :boolean
#  created_at    :datetime
#  updated_at    :datetime
#

class MuseumSection < ActiveRecord::Base
  belongs_to :museum
  has_many :museum_fields, dependent: :destroy

  scope :section , lambda {|section_name, form_name='default' | where(form_name: form_name,section_name: section_name)}

  def is_custom?
    self.custom
  end
end
