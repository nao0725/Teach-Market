Rails.application.routes.draw do

  root to: "public/homes#top"

  devise_for :users,controllers: {
  sessions:      'users/sessions',
  passwords:     'users/passwords',
  registrations: 'users/registrations'
}

end
