Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "bookings#index"
  # resources :users, except: [:destroy]

  get "calendar" => "calendarapi#index"
  # post "users" => "users#create"
  # patch "users" => "users#update"
  resources :users

  get "welcome" => "welcome_form#profile_creation", as: :welcome
  get "welcome_social" => "welcome_form#profile_social", as: :welcome_social
  get "welcome_company" => "welcome_form#company_info", as: :welcome_company
  get "welcome_release" => "welcome_form#release", as: :welcome_release

  patch "user_welcome_update" => "welcome_form#user_update", as: :welcome_update
  patch "user_welcome_finish" => "welcome_form#done_profile", as: :welcome_finish

  resources :bookings, only: [:index, :new, :show]
  get "bookings_list" => "bookings#bookings_list", as: :bookings_list
  get "booking_recording_form" => "bookings#get_recording_form", as: :get_recording_form
  post "bookings" => "bookings#create", as: :create_booking

  resources :sessions, only: [:create]
  delete 'logout' => 'sessions#destroy', as: :logout

  get "dashboard" => "dashboard#index"
  get "admin" => "dashboard#admin_dashboard"
  patch "user_update" => "dashboard#user_update", as: :dashboard_update
  patch "company_update" => "dashboard#company_update", as: :company_update
  patch "company_release_update" => "dashboard#release_update", as: :release_update

end
