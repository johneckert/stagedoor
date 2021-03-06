Rails.application.routes.draw do
  root 'application#index'
  post '/analytics_select', to: 'application#analytics_select'
  resources :contracts, only: [:index, :new, :create, :edit, :update]
  resources :companies, only: [:index, :show]
  resources :locations, only: :show
  resources :categories, only: []
  resources :designers, only: [:create, :index]

  get 'analytics', to: 'application#analytics'

  post '/sessions', to: 'sessions#create', as: 'authenticate'
  post '/sessions/destroy', to: 'sessions#destroy', as: 'logout'
end
