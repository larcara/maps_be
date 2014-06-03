class AddPubblicoToCardTemplateFiled < ActiveRecord::Migration
  def change
    add_column :card_template_fileds, :pubblico, :boolean
  end
end
