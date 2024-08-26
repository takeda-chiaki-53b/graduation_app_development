Rails.application.routes.draw do
  root "tops#index"
  resources :users, only: %i[new create]
  get "login", to: "user_sessions#new"
  post "login", to: "user_sessions#create"
  delete "logout", to: "user_sessions#destroy"

  # ブランドアカウントのルート
  namespace :brand_admin do
    resources :users, only: %i[new create]
    get "brand_admi", to: "brand_admins#new", as: :brand_admin
  end
end
