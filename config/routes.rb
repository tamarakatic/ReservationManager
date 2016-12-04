
Rails.application.routes.draw do
  devise_for :employees, controllers: { sessions: 'employees/sessions',
  registrations: 'employees/registrations' }

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

  devise_scope :system_manager do
    authenticated :system_manager do
      root 'home_page/system_manager#index'
    end
  end

    unauthenticated do
      root 'landing_page#index'
    end
  end

  root 'landing_page#index'
end
