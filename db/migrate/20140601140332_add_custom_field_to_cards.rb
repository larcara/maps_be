class AddCustomFieldToCards < ActiveRecord::Migration
  def change
    add_column :cards, :custom_1, :string
    add_column :cards, :custom_2, :string
    add_column :cards, :custom_3, :string
    add_column :cards, :custom_4, :string
    add_column :cards, :custom_5, :string
    add_column :cards, :custom_6, :string
    add_column :cards, :custom_7, :string
    add_column :cards, :custom_8, :string
    add_column :cards, :custom_9, :string
    add_column :cards, :custom_10, :string
    add_column :cards, :custom_11, :string
    add_column :cards, :custom_12, :string
    add_column :cards, :custom_13, :string
    add_column :cards, :custom_14, :string
    add_column :cards, :custom_15, :string
  end
end
