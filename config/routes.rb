Rails.application.routes.draw do
  post 'login' => 'authentication#authenticate_user'
  resources :users, only: [:create,:edit,:index,:update]
  resources :accounts, only: [:create,:index]
  resources :transfers, only: [:create]
  resources :exchanges, only: [:create]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
