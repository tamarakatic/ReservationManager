Rails.application.routes.draw do
  devise_for :managers
  devise_for :providers
  resources :seats
  resources :drinks
  resources :foods
  resources :restaurants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
