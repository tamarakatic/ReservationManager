Rails.application.routes.draw do
  devise_for :system_managers
  resources :seats
  resources :drinks
  resources :foods
  resources :restaurants
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
