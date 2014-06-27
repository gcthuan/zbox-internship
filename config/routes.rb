ZboxInternship::Application.routes.draw do

  root 'static_pages#home'

  devise_for :users, :controllers => { :registrations => "my_devise/registrations" }
  
  match '/help',    to: 'static_pages#help',    via: 'get'

  match '/users/submit',  to: 'users#submit', via: 'post'
  match '/users/select',  to: 'users#select', via: 'get'

  match '/admin', to: 'admin/static_pages#home',  via: 'get'
  match '/admin/packages/index', to: 'admin/packages#index',  via: 'get'
  match '/admin/packages/add', to: 'admin/packages#add',    via: 'post'
  match '/admin/packages/unpackage', to: 'admin/packages#unpackage',  via: 'get'
  match '/admin/questions', to: 'admin/questions#tag', via:  'get'
  match '/admin/questions/index', to: 'admin/questions#index', via:  'get'
  match '/admin/jobs/index', to: 'admin/jobs#index',  via:  'get'
  match '/admin/jobs/add_package', to: 'admin/jobs#add_package',    via: 'post'
  match '/admin/jobs/remove_package', to: 'admin/jobs#remove_package',    via: 'get'
  match '/admin/users/index', to: 'admin/users#index',  via: 'get'
  match '/admin/users/mail', to: 'admin/users#mail',  via: 'get'
  match '/admin/users/add_package', to: 'admin/users#add_package',    via: 'post'
  match '/admin/users/remove_package', to: 'admin/users#remove_package',    via: 'get'

  resources :users do
    get :autocomplete_job_name, :on => :collection
  end

  resources :jobs, only: [:show]
  resources :packages, only: [:show]

  namespace :admin do
    resources :questions
    resources :packages do
      get :autocomplete_question_name, :on => :collection
    end
    resources :jobs do
      get :autocomplete_package_name, :on => :collection
    end
    resources :users
  end
  
  
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

end
