Rails.application.routes.draw do

  # devise_scope :user do
  #   get 'users/sign_in' => 'users/sessions#new', as: 'new_user_session'
  #   post 'users/sign_in' => 'users/sessions#create', as: 'user_session'
  #   delete 'users/sign_out' => 'users/sessions#destroy', as: 'destroy_user_session'
  #   get 'users/sign_up' => 'users/registrations#new', as: 'new_user_registration'
  #   post 'users' => 'users/registrations#create', as: 'user_registration'
  #   get 'users/password/new' => 'users/passwords#new', as: 'new_user_password'
  #   get  "omniauth_callbacks" => "users/omniauth_callbacks"
  #   post "users/guest_sign_in" => "users/sessions#new_guest"
  # end

  devise_for :users, controllers: {
    sessions:      "users/sessions",
    passwords:     "users/passwords",
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
}

  # devise_scope :user do
  #   post 'users/guest_sign_in', to: 'users/sessions#new_guest'
  # end

  # devise_scope :admins do
  #   get 'admins/sign_in' => 'admins/sessions#new', as: 'new_admin_session'
  #   post 'admins/sign_in' => 'admins/sessions#create', as: 'admin_session'
  #   delete 'admins/sign_out' => 'admins/sessions#destroy', as: 'destroy_admin_session'
  # end


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
    post "/homes/guest_sign_in" => "homes#guest_sign_in"
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

end
