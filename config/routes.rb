Rails.application.routes.draw do

  root to: 'main#index'

  get :search, controller: :main
  get :export, controller: :main
  
  resources :pokemon, only: [:index, :show]
  resources :item, only: [:index, :show]
  resources :generation, only: [:index, :show]

  namespace :admin do
    resources :candies
    resources :events
    resources :alternative_skins
    resources :alternative_skin_categories
    resources :evolutions
    resources :items
    resources :item_categories
    resources :pokemons
    resources :attacks
    resources :types
    resources :generations
  end
  # mount Fae below your admin namespec
  mount Fae::Engine => '/admin'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
