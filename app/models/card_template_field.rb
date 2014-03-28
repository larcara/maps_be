# == Schema Information
#
# Table name: card_template_fields
#
#  id                :integer          not null, primary key
#  section_name      :string(255)
#  section_label     :string(255)
#  template_field_id :string(255)
#  label             :string(255)
#  enabled           :boolean
#  hidden            :boolean
#  position          :integer
#  mobile            :integer
#  open_data         :integer
#  mandatory         :boolean
#  options           :string(255)
#  option_key        :string(255)
#  field_type        :string(255)
#

class CardTemplateField < ActiveRecord::Base
  #contiene le sezioni "standard"
  scope :enabled, ->() {  where("1=1")  }

  belongs_to :template_field
end
