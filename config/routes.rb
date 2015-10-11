Rails.application.routes.draw do
  devise_for :users, controllers: { sessions: "users/sessions", registrations: "users/registrations" }

  get "profile", to: "profiles#edit", as: :profile
  post "profile", to: "profiles#update", as: :update_profile

  resources :matches, only: [:index, :show] do
    resources :approvals, only: [:update]
    resources :chats, only: [:create]
  end

  get "browse", to: "matches#show", as: :browse

  root to: "home#index"
end
