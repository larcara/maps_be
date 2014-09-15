class CreateLivingMuseumUsers < ActiveRecord::Migration
  def change
    create_table :living_museum_users do |t|
      t.string :first_name
      t.string :last_name
      t.string :user_name

      ## Token authenticatable
      t.string   :authentication_token

      t.timestamps
    end
  end
end
