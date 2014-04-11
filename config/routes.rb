MapsBe::Application.routes.draw do
  #get "registrations/create"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api, defaults: {format: :json} do
    devise_for :users,   module: "api"
    resource :museums do
      collection do
        get 'getMuseumData'
        post 'setMuseumData'

        post 'createUser'
        post 'destroyUser'
        post 'updateUser'
        get 'getUsers'


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
        post 'saveCard'
        post 'deleteCard'
        post 'saveImage'
      end

    end
    resource :config

    match "config/getSections", via: [:get, :post]
    match "config/getSectionFieldDetail", via: [:get, :post]
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
