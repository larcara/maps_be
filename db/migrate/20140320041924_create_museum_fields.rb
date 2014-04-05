class CreateMuseumFields < ActiveRecord::Migration
  def change
    create_table :museum_fields do |t|
        t.integer :museum_section_id

        t.integer :card_template_field_id
        t.string  :template_field_id
        t.string  :label
        t.boolean :enabled
        t.boolean :hidden
        t.integer :position
        t.integer :mobile
        t.integer :open_data
        t.boolean :mandatory
        t.boolean :custom
        t.string  :options
        t.string  :option_key
        t.string  :field_type
      t.timestamps
    end
  end
end
