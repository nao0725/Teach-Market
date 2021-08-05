Rails.application.routes.draw do
  
  root to: "public/homes#top"
  get 'public/help' => 'public/homes#help'

  devise_for :admins, controllers: {
    sessions:      'admins/sessions',
    passwords:     'admins/passwords',
    registrations: 'admins/registrations'
}

  devise_for :users, controllers: {
    sessions:      'users/sessions',
    passwords:     'users/passwords',
    registrations: 'users/registrations'
}

  
    resources :articles

end
