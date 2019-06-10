Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  require 'sidekiq/web'
  mount Sidekiq::Web => '/sidekiq'

  root "bookings#new_alt"
  # resources :users, except: [:destroy]

  get "calendar" => "calendarapi#index"
  # post "users" => "users#create"
  # patch "users" => "users#update"
  resources :users

  # get "geo_states/:countryId" => "geo_api#states", as: :geo_states

  get "welcome_legal" => "welcome_form#legal_info", as: :welcome_legal
  get "welcome" => "welcome_form#internet_profile", as: :welcome_profile
  get "welcome_profile_image" => "welcome_form#profile_image", as: :welcome_profile_image
  get "welcome_social" => "welcome_form#profile_social", as: :welcome_social
  get "welcome_company_legal" => "welcome_form#company_legal", as: :welcome_company_legal
  get "welcome_company_image" => "welcome_form#company_image", as: :welcome_company_image
  get "welcome_company_social" => "welcome_form#company_social", as: :welcome_company_social
  get "welcome_release" => "welcome_form#release", as: :welcome_release

  patch "user_welcome_update" => "welcome_form#user_update", as: :welcome_update
  patch "user_welcome_finish" => "welcome_form#done_profile", as: :welcome_finish

  resources :bookings, only: [:index, :new, :show] do
    resources :media_files, only: [:index, :new, :create]
  end
  resources :media_files, only: [:edit, :update]
  get 'digital_files' => 'media_files#digital_files', as: :digital_files
  delete 'delete_upload/:id' => 'media_files#delete_upload', as: :delete_upload
  patch 'user_approve_media/:id' => 'media_files#user_approve_media', as: :user_approve_media

  get "bookings_list" => "bookings#bookings_list", as: :bookings_list
  get "booking_recording_form" => "bookings#get_recording_form", as: :get_recording_form
  get "booking_test_form" => "bookings#get_test_form", as: :get_test_form
  get "booking_menu" => "bookings#booking_menu", as: :booking_menu
  post "bookings" => "bookings#create", as: :create_booking
  get "bookings_alt" => "bookings#new_alt", as: :new_alt

  resources :sessions, only: [:create]
  delete 'logout' => 'sessions#destroy', as: :logout

  get "dashboard" => "dashboard#index"
  get "admin" => "dashboard#admin_dashboard"
  patch "user_update" => "dashboard#user_update", as: :dashboard_update
  patch "company_update" => "dashboard#company_update", as: :company_update
  patch "company_release_update" => "dashboard#release_update", as: :release_update
  get "send_release" => "dashboard#send_release", as: :send_release

end
