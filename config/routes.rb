Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "dashboard#index"
  # resources :users, except: [:destroy]

  get "calendar" => "calendarapi#index"
  # post "users" => "users#create"
  # patch "users" => "users#update"
  resources :users

  get "welcome" => "welcome_form#profile_creation", as: :welcome
  
  resources :bookings, only: [:index, :new, :show]
  post "bookings" => "bookings#create", as: :create_booking

  resources :sessions, only: [:create]
  delete 'logout' => 'sessions#destroy', as: :logout

  get "dashboard" => "dashboard#index"
  get "admin" => "dashboard#admin_dashboard"
  patch "user_update" => "dashboard#user_update", as: :dashboard_update
  patch "company_update" => "dashboard#company_update", as: :company_update
  patch "company_release_update" => "dashboard#release_update", as: :release_update

end
