Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #resources :users, except: [:edit, :update, :destroy]
  resources :users do 

    root "users#index"
    get '/select_camp', to: 'camps#select', as: 'select_camp'
    get 'sort/:column(/:direction)', action: :index, on: :collection, as: 'sort_users'

    collection do
    get 'export_csv'
    end
  end 
  
  resources :camps do
  get '/camps', to: 'camps#index'
  patch 'status', on: :member
  get 'sort/:column(/:direction)', action: :index, on: :collection, as: 'sort_camps'
  collection do
    get 'export_csv'
  end
  end
  
  authenticated :user do
    root to: 'users#index', as: :authenticated_root
  end

  root to: redirect('/users/sign_in')
end
