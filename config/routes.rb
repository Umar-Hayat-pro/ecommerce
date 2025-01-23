Rails.application.routes.draw do
  # Admin routes
  namespace :admin do
    resources :orders
    resources :products do
      resources :stocks
    end
    resources :categories
    get "tenants" => "tenants#index"
  end

  # Devise routes for admins
  devise_for :admins

  # Devise routes for users
  devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions" }

  # Root path for authenticated user (Admins)
  authenticated :admin_user do
    root to: "admin#index", as: :admin_root
  end
  
  # Root path for users and authenticated users (admin)
  root "home#index"
  get "about" => "home#about"
  get "contact" => "home#contact"
  get "/profile" => "user_authentication#index"
  resources :categories, only: [:show]
  resources :products, only: [:show]
  
  # Cart and checkout routes
  get "cart" => "carts#show"
  post "checkout" => "checkouts#create"
  get "success" => "checkouts#success"
  get "cancel" => "checkouts#cancel"

  # Static pages
  get "admin" => redirect("/admin/tenants"), as: :admin
end