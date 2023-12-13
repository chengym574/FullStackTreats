Rails.application.routes.draw do
  get 'about', to: 'pages#show_about', as: :pages_about
  get 'contact', to: 'pages#show_contact', as: :pages_contact

  get 'about/edit', to: 'pages#edit_about', as: :edit_about
  patch 'about/update', to: 'pages#update_about', as: :update_about

  get 'contact/edit', to: 'pages#edit_contact', as: :edit_contact
  patch 'contact/update', to: 'pages#update_contact', as: :update_contact

  devise_for :users, controllers: {
  sessions: 'users/sessions',
  registrations: 'users/registrations'
  }
  
  root to: "home#index"

  resources :categories, only: [:show]

  resources :products

  get '/search', to: 'products#search'

  post '/add_to_cart/:id', to: 'cart#add_to_cart', as: 'add_to_cart'
  patch '/update_quantity/:id', to: 'cart#update_quantity', as: 'update_quantity'
  get '/remove_item/:id', to: 'cart#remove_item', as: 'remove_item'
  get '/cart', to: 'cart#show_cart', as: 'cart'

end
