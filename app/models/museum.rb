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

has_many :museum_fields
has_many :cards
has_many :users


def sections(catalog="default")
  museum_fields.where(form_name: catalog).select(:section_name, :section_label).distinct.map{|x| [x.section_name,x.section_label]}
end

def availables_custom_fields
  free_custom_fields = TemplateField.where(["field_name like 'custom_%' and id not in (?)",self.museum_fields.map(&:template_field_id)])

  free_custom_fields
end
  def initMuseum(catalog="default")
    return if self.museum_fields.where(form_name: catalog).count > 0

    CardTemplateField.enabled.each do |t|
      attrib=t.attributes.clone
      attrib.delete("id")
      x = self.museum_fields.build( attrib)
      x.card_template_field_id=t.id
      x.form_name=catalog
    end
    self.save
  end


end
