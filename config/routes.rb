DeviseTest::Application.routes.draw do

  get 'packages/new'
  get 'questions/new'

  root 'static_pages#home'
  devise_for :users
  
  match '/users/index', to: 'users#index',  via: 'get'
  match '/users/mail', to: 'users#mail',  via: 'get'
  match '/users/add_package', to: 'users#add_package',    via: 'post'
  match '/packages/index', to: 'packages#index',  via: 'get'
  match '/questions/index', to: 'questions#index',  via: 'get'
  match '/help',    to: 'static_pages#help',    via: 'get'
  match '/packages/add', to: 'packages#add',    via: 'post'
  match '/packages/unpackage', to: 'packages#unpackage',  via: 'get'
  match '/questions', to: 'questions#tag', via:  'get'
  resources :users
  resource :users, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  resources :questions
  resources :packages
  
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
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

  if Rails.env.development?
    app = ActionDispatch::Static.new(
      lambda{ |env| [404, { 'X-Cascade' => 'pass'}, []] },
      Rails.application.config.paths['public'].first,
      Rails.application.config.static_cache_control
    )

    mount app, :at => '/', :as => :public
  end

end
