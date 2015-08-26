Rails.application.routes.draw do


  namespace :admin do
    resources :locales

    resources :people do
      post :import, on: :collection
    end

    resources :venues do
      post :import, on: :collection
    end

    resources :events do
      post :import, on: :collection
    end
  end

  with_options only: [ :show, :index ] do
    resources :events
    resources :people
    resources :venues
  end
  
  resource :session, only: [ :new, :create, :destroy ] do
    post :token, constraints: { format: "json" }
  end

  resources :locale, only: [ :show ]

  get :me, controller: :people, action: :show

  with_options controller: :home do
    get :dashboard, action: :dashboard
    get :privacy, action: :privacy
    root action: :index
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
