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

  resources :products, only: [:show] 

  get '/search', to: 'products#search'

end
