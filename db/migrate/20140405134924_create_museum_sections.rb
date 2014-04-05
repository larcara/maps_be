class CreateMuseumSections < ActiveRecord::Migration
  def change
    create_table :museum_sections do |t|


      t.integer :museum_id
      t.string  :form_name
      t.string  :section_name
      t.string  :section_label
      t.boolean :custom
      t.boolean :visible

      t.timestamps
    end
  end
end
