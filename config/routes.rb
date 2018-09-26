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
  
  get 'generations', to: 'generation#index', as: 'generations'
  get 'gen/', to: redirect('/generations')
  get 'gen/:id', to: 'generation#show', as: 'generation'
  get 'attaques/', to: 'attack#index', as: 'attacks'
  get 'attaque/', to: redirect('/attaques')
  get 'attaque/:id', to: 'attack#show', as: 'attack'

  resources :pokemon, only: [:index, :show], param: :num
  resources :item, only: [:index, :show]
  resources :type, only: [:index, :show]
  resources :article
  resources :event

end
