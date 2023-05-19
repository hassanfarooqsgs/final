Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  resources :users do
  get 'export_csv', on: :collection
  end
  #resources :users, except: [:edit, :update, :destroy]


 

end
