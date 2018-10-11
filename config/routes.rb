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
  resources :articles, only: [:index, :show]
  resources :events, only: [:index, :show]
  resources :eggs, only: [:index, :show]
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

end
