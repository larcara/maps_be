class CreateTemplateFields < ActiveRecord::Migration
  def change
    create_table :template_fields do |t|


      t.string :field_name
      t.string :field_label
      t.string :field_description
      t.string :field_data_type
      t.boolean :custom
      



      t.timestamps
    end
    add_index :template_fields, :field_name,                unique: true
  end
end
