Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "users#index"
  # resources :users, except: [:destroy]

  get "our-users" => "users#new"
  post "users" => "users#create"
end
