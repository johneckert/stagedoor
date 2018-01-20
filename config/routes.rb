Rails.application.routes.draw do
  resources :contracts
  resources :venues
  resources :companies
  resources :locations
  resources :categories
  resources :designers
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
