Rails.application.routes.draw do

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
  
  get 'generations', to: 'generations#index', as: 'generations'
  get 'gen/', to: redirect('/generations')
  get 'gen/:id', to: 'generations#show', as: 'generation'
  get 'attaques/', to: 'attacks#index', as: 'attacks'
  get 'attaque/', to: redirect('/attaques')
  get 'attaque/:id', to: 'attacks#show', as: 'attack'

  resources :pokemons, only: [:index, :show], param: :num
  resources :items, only: [:index, :show]
  resources :types, only: [:index, :show]
  resources :articles
  resources :events

end
