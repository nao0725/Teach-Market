Rails.application.routes.draw do

  root to: "public/homes#top"
  get '/help' => 'public/homes#help'
  get '/home' => 'public/homes#home'

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
}

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
}

  scope module: :public do
     resources :articles do
       resource :bookmarks, only: [:show, :create, :destroy]
       resources :comments, only: [:create, :destroy]
     end
     resources :users, only: [:show, :edit, :update ] do
       resource :relationships, only: [:create, :destroy]
       get "followings" => "relationships#followings", as: "followings"
       get "followers" => "relationships#followers", as: "followers"
     end 
     resources :rank
  end



end
