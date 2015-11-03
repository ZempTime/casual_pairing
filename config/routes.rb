Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  get "profile", to: "profiles#edit", as: :profile
  post "profile", to: "profiles#update", as: :update_profile

  resources :matches, only: [:index, :show] do
    member do
      get :show_react
    end
    resources :approvals, only: [:update]
    resources :chats, only: [:index, :create]
  end

  get "browse", to: "matches#show", as: :browse

  root to: "home#index"
end
