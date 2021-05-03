Rails.application.routes.draw do
  post 'auth_user' => 'authentication#authenticate_user'
  resources :users, only: [:create,:edit,:index,:update]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
