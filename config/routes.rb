Rails.application.routes.draw do
  get '/get_articles' => 'application#get_articles'
  get '/search' => 'application#search'

  post 'comments/create/' => 'comments#create'
  get 'comments/delete/:id' => 'comments#destroy'

  get 'police_regions/compare' => 'police_regions#compare'
  get 'police_regions/:id' => 'police_regions#show'
  get 'police_regions/' => 'police_regions#index'
  get 'police_crimes/list'

  get 'users/register' => 'users#register'
  get 'users/all' => 'users#get_all'
  get 'users/list' => 'users#list'
  post 'users/new' => 'users#new'
  post 'users/delete' => 'users#delete'
  
  get 'news/list' => 'news#list'
  post 'news/delete' => 'news#delete'
  
  post 'sessions/create' => 'sessions#create'
  get 'sessions/destroy' => 'sessions#destroy'
  get 'sessions/locale/:lang' => 'sessions#change_language'
  
  resources :users
  resources :crimes
  resources :regions

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'application#index'

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
