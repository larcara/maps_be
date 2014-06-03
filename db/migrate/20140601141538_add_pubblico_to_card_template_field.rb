class AddPubblicoToCardTemplateField < ActiveRecord::Migration
  def change
    add_column :card_template_fields, :pubblico, :boolean
  end
end
