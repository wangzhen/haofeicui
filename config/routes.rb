Haofeicui::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.
   match '/about' ,:to => "home#about"
  resources :home do
    collection do
         get :aboutus
         get :question
         get :buy
    end
  end

  resources :news
  resources :articles
  resources :contacts
  resources :products  do
    resources  :product_comments
    resources :product_contacts
    member do
     get   :alipay
     get   :buy
    end
  end
  resources :orders
  resources :forgotten_passwords
  resource :ajax do
    collection do
   post :province_select
   post :city_select
   get :copy_user_info
   get :color_sort
   get :sort_sort 
   get  :change_product_is_public 
   get  :category_sort 
   get :change_category_is_public 
   get  :set_recomm_product 
   get :delete_product_image
   get :product_image_sort 
   get :delete_article_image
   get  :article_image_sort 
    end
 
  end



  namespace :admin do 
    match '/'  , :to => "sessions#new"
 
    resources :sessions  do
        get :home , :on => :collection
        get :logout , :on => :collection
    end
    
    resources :products , :collection => {:select => :get}
    resources :product_contacts
    resources :administrators
    resources :authors
    resources :author_categories
    resources :product_comments
    resources :admin_products
    resources :users , :has_many => :roles , :collection => {:select => :get}
    resources :roles , :has_many => :users
    resources :permissions , :has_many => :roles
    resources :colors
    resources :sorts
    resources :product_images
    resources :articles , :collection => {:upload => :post}
    resources :admin_articles , :collection => {:upload => :post}
    resources :article_images
    resources :admin_article_images
    resources :article_comments
    resources :article_comments
    resources :admin_helpers
    resources :basetables
    resources :categories
    resources :contacts
    resources :mail_settings  , :collection => {:setmail => :get}
    resources :orders
    resources :order_lines
    resources :webs
  end

  



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
   root :to => 'products#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end




#
#  map.resources :news
#  map.resources :articles
#  map.resources :contacts
#  map.resources :products , :has_many => [:product_comments,:product_contacts] , :member => {:alipay => :post ,:buy => :get}
#  map.resources :orders
#  map.resources :forgotten_passwords
#  map.resource :ajax
#
#  map.resources :ajax  ,:collection => {
#    :province_select=>:post ,
#    :city_select =>:post,
#    :copy_user_info => :get,
#    :color_sort => :get,
#    :sort_sort => :get,
#    :change_product_is_public => :get,
#    :category_sort => :get,
#    :change_category_is_public => :get,
#    :set_recomm_product => :get ,
#    :delete_product_image=>:get ,
#    :product_image_sort =>:get ,
#    :delete_article_image=>:get ,
#    :article_image_sort =>:get
#  }
#
#  map.resource :cart, :only => [:show, :update] do |cart|
#    cart.resources :items, :controller => 'cart_items', :only => [:create, :destroy]
#  end
#  map.forgot_password '/forgot_password', :controller => 'forgotten_passwords', :action => 'new'
#  map.change_password '/change_password/:reset_code', :controller => 'forgotten_passwords', :action => 'reset'
#  map.user '/users/:id', :controller => 'users', :action => 'show'
#  map.logout '/logout', :controller => 'sessions', :action => 'destroy'
#  map.login '/login', :controller => 'sessions', :action => 'new'
#  map.register '/register', :controller => 'users', :action => 'create'
#  map.signup '/signup', :controller => 'users', :action => 'new'
#  map.activate '/activate', :controller => 'users', :action => 'activate'
#  map.update '/update', :controller => 'users', :action => 'update'
#  #  map.activate '/activate/:activation_code', :controller => 'users', :action => 'activate', :activation_code => nil
#  map.admin_logout "admin/logout",:controller => "admin/sessions",:action => "logout"
#  map.about "/about",:controller => "/home",:action => "about"
#  map.resource :user ,  :only=> [:edit ,:update , :new]
#  map.resources :sessions
#
#  # The priority is based upon order of creation: first created -> highest priority.
#
#  # Sample of regular route:
#  #   map.connect 'products/:id', :controller => 'catalog', :action => 'view'
#  # Keep in mind you can assign values other than :controller and :action
#
#  # Sample of named route:
#  #   map.purchase 'products/:id/purchase', :controller => 'catalog', :action => 'purchase'
#  # This route can be invoked with purchase_url(:id => product.id)
#
#  # Sample resource route (maps HTTP verbs to controller actions automatically):
#  #   map.resources :products
#
#  # Sample resource route with options:
#  #   map.resources :products, :member => { :short => :get, :toggle => :post }, :collection => { :sold => :get }
#
#  # Sample resource route with sub-resources:
#  #   map.resources :products, :has_many => [ :comments, :sales ], :has_one => :seller
#
#  # Sample resource route with more complex sub-resources
#  #   map.resources :products do |products|
#  #     products.resources :comments
#  #     products.resources :sales, :collection => { :recent => :get }
#  #   end
#
#  # Sample resource route within a namespace:
#  map.namespace :admin do |admin|
#    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
#    admin.home '/' , :controller => :sessions ,:action => :new
#    admin.resources :sessions , :collection => {:home => :get}
#    admin.resources :products , :collection => {:select => :get}
#    admin.resources :product_contacts
#    admin.resources :administrators
#    admin.resources :authors
#    admin.resources :author_categories
#    admin.resources :product_comments
#    admin.resources :admin_products
#    admin.resources :users , :has_many => :roles , :collection => {:select => :get}
#    admin.resources :roles , :has_many => :users
#    admin.resources :permissions , :has_many => :roles
#    admin.resources :colors
#    admin.resources :sorts
#    admin.resources :product_images
#    admin.resources :articles , :collection => {:upload => :post}
#    admin.resources :admin_articles , :collection => {:upload => :post}
#    admin.resources :article_images
#    admin.resources :admin_article_images
#    admin.resources :article_comments
#    admin.resources :article_comments
#    admin.resources :admin_helpers
#    admin.resources :basetables
#    admin.resources :categories
#    admin.resources :contacts
#    admin.resources :mail_settings  , :collection => {:setmail => :get}
#    admin.resources :orders
#    admin.resources :order_lines
#    admin.resources :webs
#  end
#  map.namespace :admin do |admin|
#    # Directs /admin/products/* to Admin::ProductsController (app/controllers/admin/products_controller.rb)
#    admin.home '/' , :controller => :users ,:action => :index
#    admin.resources :users
#
#  end
#
#  # You can have the root of your site routed with map.root -- just remember to delete public/index.html.
#  map.root :controller => "products" ,:aciton=>:index
#
#  # See how all your routes lay out with "rake routes"
#
#  # Install the default routes as the lowest priority.
#  # Note: These default routes make all actions in every controller accessible via GET requests. You should
#  # consider removing the them or commenting them out if you're using named routes and resources.
#  map.connect ':controller/:action/:id'
#  map.connect ':controller/:action/:id.:format'