Rails.application.routes.draw do

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".
  # devise_scope :user do
  #   get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  # end
  # You can have the root of your site routed with "root"
    root 'welcome#index'
    get '/feed' => 'user_posts#feed'
    get '/profile' => 'users#show'
    resources :meetup_post_votes
    resources :comments
    resources :users do
      member do
        get :following, :followers, :upvotes, :favorites
      end
      resources :taken_courses
      resources :current_courses
      resources :future_courses
      resources :educations
    end
    resources :meetups do
      resources :meetup_members
      resources :meetup_posts do
        resources :meetup_post_votes, only: [:create, :destroy]
        resources :comments, shallow: true
      end
    end

    resources :follows, only: [:create, :destroy]

    resources :organizations do
      resources :courses
    end

    resources :user_posts do
      resources :post_comments
      resources :upvotes
      resources :favorites
    end

    resources :courses do
      resources :posts
    end

    resources :course_posts do
      resources :course_comments
    end


  # Example of regular route:

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
