# == Schema Information
#
# Table name: museum_fields
#
#  id                     :integer          not null, primary key
#  museum_section_id      :integer
#  card_template_field_id :integer
#  template_field_id      :string(255)
#  label                  :string(255)
#  enabled                :boolean
#  hidden                 :boolean
#  position               :integer
#  mobile                 :integer
#  open_data              :integer
#  mandatory              :boolean
#  custom                 :boolean
#  options                :string(255)
#  option_key             :string(255)
#  field_type             :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

class MuseumField < ActiveRecord::Base


  #scope :sections , lambda {|section_name, form_name='default' | where(form_name: form_name,section_name: section_name)}
  belongs_to :museum_section
  scope :custom_fields , -> { where(custom: true)}

  belongs_to :template_field
  def field_name
    template_field.field_name
  end

  def as_json(options = { })
    h = super(options)
    h[:field_name]   = field_name if field_name
    h
  end
  #def sections(section_name, form_name='default')
  #  self.museum_section.where(form_name: form_name,section_name: section_name)
  #end
end
