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

  devise_scope :manager do
    authenticated :manager do
      root 'manager#index', as: :manager_home
    end

    unauthenticated do
      root 'landing_page#index'
    end
  end

  root 'landing_page#index'
end
