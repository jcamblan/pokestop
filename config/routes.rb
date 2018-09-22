Rails.application.routes.draw do

  root to: 'main#index'

  get :search, controller: :main
  get :export, controller: :main
  get :calendar, controller: :event
  
  get 'gen/', to: 'generation#index', as: 'generations'
  get 'gen/:id', to: 'generation#show', as: 'generation'
  get 'comp', to: 'attack#index', as: 'attacks'
  get 'comp/:id', to: 'attack#show', as: 'attack'

  resources :pokemon, only: [:index, :show], param: :num
  resources :item_category, only: [:index, :show]
  resources :item, only: [:index, :show]
  resources :attack, only: [:index, :show]
  resources :type, only: [:index, :show]
  resources :article
  resources :event

  namespace :admin do
    resources :eggs
    resources :article_categories
    resources :articles
    resources :candies
    resources :events
    resources :alternative_skins
    resources :alternative_skin_categories
    resources :evolutions
    resources :items
    resources :item_categories
    resources :pokemons
    resources :attacks do
      post 'filter', on: :collection
    end
    resources :attack_categories
    resources :types
    resources :generations
  end
  # mount Fae below your admin namespec
  mount Fae::Engine => '/admin'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
