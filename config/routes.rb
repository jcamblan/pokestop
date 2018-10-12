Rails.application.routes.draw do

  devise_for :users
  root to: 'main#index'

  get :search, controller: :main
  get :export, controller: :main
  get :calendar, controller: :events

  resources :pokemons, only: [:index, :show]
  resources :objets, only: [:index, :show], controller: 'items', as: :items
  resources :types, only: [:index, :show]
  resources :attaques, only: [:index, :show], controller: 'attacks', as: :attacks
  resources :generations, only: [:index, :show]
  resources :articles, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :oeufs, only: [:index, :show], controller: 'eggs', as: :eggs
  resources :tags, only: [:show]

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
    resources :items
    resources :alternative_skins
    resources :alternative_skin_categories
    resources :evolutions
  end


  match "/404", to: "errors#not_found", via: :all
  match "/422", to: "errors#unacceptable", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

end
