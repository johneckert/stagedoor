Rails.application.routes.draw do
  root 'application#index'
  post '/analytics_select', to: 'application#analytics_select'
  resources :contracts, only: [:new, :create, :index]
  resources :companies, only: :show
  resources :locations, only: :show
  resources :categories, only: []
  resources :designers, only: [:new, :create, :index]

  get '/sessions/new', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'authenticate'
  post '/sessions/destroy', to: 'sessions#destroy', as: 'logout'
end
