ActionController::Routing::Routes.draw do |map|
  map.resources :serials

  map.resources :statuses
  map.resources :products
  map.resources :locations
  map.resources :users

  map.resources :parsers
  ###  
  #map.login '/login', :controller => 'admin', :action => 'login'
  #map.logout '/logout', :controller => 'admin', :action => 'logout'
  #map.contact '/contact', :controller => 'admin', :action => 'contact'
  #map.email '/email', :controller => 'admin', :action => 'email'

  #map.resources :logs, :except => :show
  map.resources :logs, :collection => { :to_csv => :get, :search => :get }    
  #map.resources :logs, :collection => { :search => :get }

  #map.show 'logs/:id/show', :controller => 'logs', :action => 'show'
  #map.basic_search 'logs/basic_search', :controller => 'logs', :action => 'basic_search' 
  #map.show_advanced_search 'logs/show_advanced_search', :controller => 'logs', :action => 'show_advanced_search'
  #map.get_content 'logs/get_content', :controller => 'logs', :action => 'get_content'
  #map.to_csv 'logs/to_csv', :controller => 'logs', :action => 'to_csv'
  ###

  # The priority is based upon order of creation: first created -> highest priority.

  # Sample of regular route:
  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   map.resources :products

  # Sample resource route with options:
  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }

  # Sample resource route with sub-resources:
  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
  
  # Sample resource route with more complex sub-resources
  #   map.resources :products do |products|
  #     products.resources :comments
  #     products.resources :sales, :collection => { :recent => :get }
  #   end

  # Sample resource route within a namespace:
  #   map.namespace :admin do |admin|
  #     # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
  #     admin.resources :products
  #   end

  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
  # map.root :controller => "welcome"

  # See how all your routes lay out with "rake routes"

  # Install the default routes as the lowest priority.
  # Note: These default routes make all actions in every controller accessible via GET requests. You should
  # consider removing or commenting them out if you're using named routes and resources.
  map.root :controller => "logs"
  map.connect ':controller/:action/:id.:format'
  map.connect ':controller/:action/:id'
end
