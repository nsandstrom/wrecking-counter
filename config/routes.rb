Rails.application.routes.draw do

  resources :stations, except: [:new, :create, :destroy] do
    collection do
      get :remaining
    end
    member do
      put 'reset'
    end
  end

  resources :rounds

  resources :teams, except: [:new, :create, :destroy] do
    member do
      put "reset"
    end
  end

  resources :reports, except: [:index, :new, :create, :show, :edit, :update, :destroy] do
    collection do
      get 'get_time_to_start'
      get 'tts' => 'reports#get_time_to_start', as: nil
      get 'get_time'
      get 'time?' => 'reports#get_time', as: nil
      post 'set_boost'
      post 'set_mission'
    end
    member do
      get 'set_owner'
      get 'so' => 'reports#set_owner', as: nil
      get 'get_owner'
      get 'go' => 'reports#get_owner', as: nil
      get 'battery_level'
      get 'bl' => 'reports#battery_level', as: nil
      get 'under_capture'
      get 'uc' => 'reports#under_capture', as: nil
      get 'get_boost'
      get 'gb' => 'reports#get_boost', as: nil
      get 'get_time_to_start' => 'reports#get_station_time_to_start'
      get 'tts' => 'reports#get_station_time_to_start', as: nil
      get 'submit_calibration_code'
      get 'scc' => 'reports#submit_calibration_code', as: nil
      get 'verify_calibration_code'
      get 'vcc' => 'reports#verify_calibration_code', as: nil
    end
  end

  put 'reset_all' => 'application#reset'

  resources :thirdgift, only: :index do
  end

  resources :public, only: :index do
    collection do
      resources :teams, only: [:index, :show] do
      end
    end
  end

  # get 'public' => 'public#index', as: :public

  resources :users

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'




  get 'index' => 'admin#index'
  root 'public#index'
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
