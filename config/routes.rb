Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  resources :users do
    resources :photos, :only => [:show, :create, :destroy] do
      resources :likes, :defaults => {:likeable => 'Photo'}, :only => [:create, :destroy]
      resources :comments, :defaults => {:commentable => 'Photo'}, :only => [:create, :destroy] do
        resources :likes, :defaults => {:likeable => 'Comment'}, :only => [:create, :destroy]
      end
    end
  end

  resources :posts do
    resources :comments, :defaults => {:commentable => 'Post'}, :only => [:create, :destroy] do
      resources :likes, :defaults => {:likeable => 'Comment'}, :only => [:create, :destroy]
    end
    resources :likes, :defaults => {:likeable => 'Post'}, :only => [:create, :destroy]
  end

  resources :friendings, :only => [:create, :destroy]
  resources :session, :only => [:new, :create, :destroy, :index]

  #Custom Routes
  get'users/:id/newsfeed/' => 'newsfeeds#index', as: :user_newsfeed
  get 'users/:id/new_photo/' => 'users#new_photo', as: :new_user_photo
  get 'users/:id/timeline' => 'users#timeline', as: :user_timeline
  get 'users/:id/friends' => 'users#friends', as: :user_friends
  post 'users/search' => 'users#search', as: :user_search
  post 'users/:id/profile_photo/:photo_id' => 'profiles#set_profile_photo', as: :user_profile_photo


  root 'session#index'

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
