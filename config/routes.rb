Rails.application.routes.draw do

  devise_for :users
  root to: 'main#index'

  get :search, controller: :main
  get :export, controller: :main
  get :calendar, controller: :events

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
    resources :generations
    resources :items
    resources :types
    resources :attacks
    resources :articles
    resources :tags
    resources :images
  end

end
