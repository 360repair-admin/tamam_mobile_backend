Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  namespace :api do
    namespace :v1 do
      namespace :auth do
        post "otp", to: "otp#create"
        post "otp/verify", to: "otp#verify"
        post "signup", to: "signup#create"
      end

      get "me", to: "profile#show"
      patch "me", to: "profile#update"
      post "me/delete/request-otp", to: "profile#request_deletion_otp"
      delete "me", to: "profile#destroy"

      resources :addresses, only: [:index, :create, :update, :destroy]
    end
  end

  mount Faulty::Engine => "/faulty"
end
