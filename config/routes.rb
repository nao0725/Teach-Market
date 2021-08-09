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
       resource :comments, only: [:create, :destroy]
     end
  end



end
