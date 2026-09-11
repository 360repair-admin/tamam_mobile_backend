Faulty::Engine.routes.draw do
  root to: "errors#index"

  resources :errors, only: [:index, :show] do
    member do
      patch :resolve
      patch :assign
    end

    resources :comments, only: [:create]
  end
end
