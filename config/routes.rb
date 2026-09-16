Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "admin/dashboard#index"

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post "otp", to: "otp#create"
        post "otp/verify", to: "otp#verify"
        post "signup", to: "signup#create"
        post "logout", to: "otp#logout"
      end

      get "me", to: "profiles#show"
      patch "me", to: "profiles#update"
      delete "me", to: "profiles#destroy"

      post "me/edit/otp", to: "profiles#request_profile_edit_otp"
      post "me/delete/otp", to: "profiles#request_profile_deletion_otp"

      resources :addresses, only: [ :index, :create, :update, :destroy ]
      resources :notifications, only: [ :index, :update ]
      resources :vehicles
    end
  end

  namespace :admin do
    root "dashboard#index"

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"

    resources :customers, only: [ :index, :show ]
    resources :vehicle_makes
    resources :colors
    resources :service_categories, only: %i[index show]
    resources :devices, only: [:index, :create, :destroy]
  end

  mount Faulty::Engine => "/faulty"
end
