MapsBe::Application.routes.draw do

  #devise_for :living_museum_users
  #get "registrations/create"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: {format: :json} do

    devise_for :users,   module: "api"
    devise_for :living_museum_users,   module: "api",  :controllers => {  :sessions=>"api/living_museum_sessions"}
    resource :museums do
      collection do
        get 'getMuseumData'
        post 'setMuseumData'

        post 'createUser'
        post 'destroyUser'
        post 'updateUser'
        get 'getUsers'
        get 'getProfile'


        get 'getCatalogs'
        post 'createCatalog'

        get 'getSections'
        get 'getSectionDetail'
        post 'createSection'
        post 'deleteSection'


        post 'addFieldToSection'
        post 'removeFieldFromSection'
        post 'setFieldDetails'
        post 'updateSection'

        get 'getCard'
        post 'findCard'
        post 'saveCard'
        post 'deleteCard'
        post 'saveImage'
        post 'deleteImage'

        post 'import'
      end

    end
    resource :config
    resources :options

    match "config/getSections", via: [:get, :post]
    match "config/getSectionFieldDetail", via: [:get, :post]
    match "living_museum/reset", via: [:delete]
    match "living_museum/createUser", via: [:post]
    match "living_museum/requestResetPassword", via: [:post]
    match "living_museum/resetPassword", via: [:post]

    #match "living_museum/deleteUser", via: [:get, :post]
    #match "living_museum/destroyUser", via: [:get, :post]

    match "living_museum/searchCards", via: [:get]
    match "living_museum/saveSearch", via: [:post]
    match "living_museum/getSearch", via: [:get]
    match "living_museum/listSearch", via: [:get]
    match "living_museum/deleteSearch", via: [:delete]
    #match "living_museum/exportCard", via: [:get, :post]



  end


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'api/base#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controllers actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
