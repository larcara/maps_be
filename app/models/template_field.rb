# == Schema Information
#
# Table name: template_fields
#
#  id                :integer          not null, primary key
#  field_name        :string(255)
#  field_label       :string(255)
#  field_description :string(255)
#  field_data_type   :string(255)
#  custom            :boolean
#  created_at        :datetime
#  updated_at        :datetime
#

class TemplateField < ActiveRecord::Base


  has_many :card_template_fields
  has_many :museum_fields

  scope :custom_fields , -> { where(custom: true)}
  #has_many :museum_fields

end
