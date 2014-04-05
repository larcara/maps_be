# == Schema Information
#
# Table name: museums
#
#  id         :integer          not null, primary key
#  museo_id   :string(255)
#  name       :string(255)
#  city       :string(255)
#  address    :string(255)
#  telephone  :string(255)
#  logo       :string(255)
#  website    :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Museum < ActiveRecord::Base

has_many :museum_sections
has_many :museum_fields, through: :museum_sections
has_many :cards
has_many :users


def sections(catalog="default")
  museum_sections.where(form_name: catalog).select(:section_name, :section_label).distinct.map{|x| [x.section_name,x.section_label]}
end

def availables_custom_fields
  free_custom_fields = TemplateField.custom_fields.where(["id not in (?)",self.museum_fields.custom_fields.map(&:template_field_id)])

  free_custom_fields
end
def initMuseum(catalog="default")
  return if self.museum_sections.where(form_name: catalog).count > 0

  CardTemplateField.enabled.each do |t|
    attrib=t.attributes.clone
    attrib.delete("id")
    self.museum_sections.find_or_initialize_by(form_name: catalog, section_name: attrib.delete("section_name")) do |section|
      section.section_label=attrib.delete("section_label")
      section.custom=false
      section.visible=true
      f=section.museum_fields.build( attrib)
      f.card_template_field_id=t.id
    end

  end
  self.save
end

def  section_fields(section_name, form_name='default')
  section=museum_sections.where(form_name: form_name,section_name: section_name).first
  if section
    return section.fields
  else
    return false
  end
end


end
