class AddCustom0ToCards < ActiveRecord::Migration
  def change
    add_column :cards, :custom_0, :string
    TemplateField.create(field_name: "custom_15", field_label: "label_custom_15", field_description: "description_custom_15", field_data_type: "varchar",  custom: true)
    CardTemplateField.update_all(position: 0)
  end
end
