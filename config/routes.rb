Rails.application.routes.draw do
  devise_for :employees
  devise_for :system_managers
  devise_for :customers
  devise_for :managers
  devise_for :providers

  resources :seats
  resources :drinks
  resources :foods
  resources :restaurants
end
