Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  #resources :users, except: [:edit, :update, :destroy]

  resources :users do
    collection do
      get 'export_csv'
    end
  end 
  
root "users#index"
end
