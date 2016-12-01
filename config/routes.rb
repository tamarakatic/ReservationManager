
Rails.application.routes.draw do
  namespace :home_page do
    get 'employee_home/index'
  end

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
      root 'home_page/manager_home#index'
    end

    unauthenticated do
      root 'landing_page#index'
    end
  end

  devise_scope :employee do
    authenticated :employee do
      root 'home_page/employee_home#index'
    end

    unauthenticated do
      root 'landing_page#index'
    end
  end

  root 'landing_page#index'
end
