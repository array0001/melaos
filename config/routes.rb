RailsProjects::Application.routes.draw do
  
  resources :products
  resources :users #ResT(TODAS LAS REST) URLS this is generating magically creating show action and new action from users
  resources :sesiones,  :only => [:new, :create, :destroy] # limitando las acciones para que se generen los urls
  resources :posts, :only => [:create, :destroy]
  
  root :to => 'pages#home'
  match '/contacto', :to =>'pages#contacto' #NAME ROUTE! -> contacto_path OR contacto_URL
  match '/about', :to =>'pages#about'
  match '/help', :to => 'pages#help'
  match '/registro',:to =>'users#new' 
  match '/signin', :to => 'sesiones#new'
  match '/signout', :to => 'sesiones#destroy' #ver 9:sessionss-9:29
  match '/products', :to => redirect('pages#home')
  #match '/users/:id'  => "users#show"
  #match '/users', :to => 'users#'
  

  get "pages/home"
  get "pages/contacto"
  get "pages/about"
  get "pages/help"
  get "users/new"
  
  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
