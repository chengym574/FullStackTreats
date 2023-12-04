Rails.application.routes.draw do
  get 'home/index'

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }
  
  root to: "home#index"

  resources :categories, only: [:show]

  resources :products, only: [:show] 

end
