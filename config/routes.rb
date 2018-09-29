Rails.application.routes.draw do

  get 'admin/index'
  root to: 'main#index'

  # Gestion des utilisateurs ----------------------------------------------------

  get '/signup', to: 'users#new'
  post '/signup',  to: 'users#create'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users

  get :search, controller: :main
  get :export, controller: :main
  get :calendar, controller: :event

  resources :pokemons, only: [:index, :show], param: :num
  resources :items, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :attacks, only: [:index, :show]
  resources :generations, only: [:index, :show]
  resources :articles
  resources :events
  resources :eggs

  get '/admin', to: 'admin#index'
  namespace :admin do
    resources :pokemons
  end

end
