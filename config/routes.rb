Rails.application.routes.draw do

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}

  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  end

  devise_for :admins, controllers: {
    sessions:      "admins/sessions",
    passwords:     "admins/passwords",
    registrations: "admins/registrations"
}

  scope module: :public do
    root to: "homes#top"
    get "/help" => "homes#help"
    get "/home" => "homes#home"
    get "/search" => "homes#search"
    get "/rank" => "ranks#rank"

    get "unsubscribe/:name" => "homes#unsubscribe", as: "confirm_unsubscribe"
    patch ":id/withdraw/:name" => "homes#withdraw", as: "withdraw_user"
    put "withdraw/:name" => "users#withdraw"

   resources :notifications, only: [:index]

   resources :articles do
     resource :bookmarks, only: [:show, :create, :destroy]
     resources :comments, only: [:create, :destroy]
   end

   resources :users, only: [:index, :show, :edit, :update ] do
     resource :relationships, only: [:create, :destroy]
     get "followings" => "relationships#followings", as: "followings"
     get "followers" => "relationships#followers", as: "followers"
   end
 end

 namespace :admins do
   resources :users, except: [:new, :create]
 end

 get "admins" => "admins/users#admins"

end
