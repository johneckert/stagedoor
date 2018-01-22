Rails.application.routes.draw do
  root 'application#index'
  resources :contracts
  resources :venues
  resources :companies
  resources :locations
  resources :categories
  resources :designers, only: [:new, :create]
  get '/sessions/new', to: 'sessions#new', as: 'login'
  post '/sessions', to: 'sessions#create', as: 'authenticate'
  post '/sessions/destroy', to: 'sessions#destroy', as: 'logout'
end
