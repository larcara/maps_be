ActiveAdmin.register User do

  menu :priority => 2
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :email, :password,:role,:museum_id,:password_confirmation


  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    column :role
    column :museum
    actions
  end

  filter :email
  filter :museum
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "Admin Details" do
      f.input :email
      f.input :role
      f.input :museum_id
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  #form do |f|
  #  f.inputs do
  #    f.input :email
  #    #f.input :password
  #    f.input :role
  #    f.input :museum_id
  #  end
  #  f.actions
  #end
  
end
