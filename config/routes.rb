Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "users#index"
  # resources :users, except: [:destroy]

  get "our_users" => "users#new"
  post "users" => "users#create"

  resources :sessions, only: [:create]
  delete 'logout' => 'sessions#destroy', as: :logout

end
