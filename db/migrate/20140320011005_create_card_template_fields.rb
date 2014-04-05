class CreateCardTemplateFields < ActiveRecord::Migration
  def change
    create_table :card_template_fields do |t|
      t.string  :section_name
      t.string  :section_label
      t.string  :template_field_id
      t.string  :label
      t.boolean :enabled
      t.boolean :hidden
      t.integer :position
      t.integer :mobile
      t.integer :open_data
      t.boolean :mandatory
      t.string  :options
      t.string  :option_key
      t.string  :field_type
      t.boolean :custom

    end
  end
end
