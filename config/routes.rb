Rails.application.routes.draw do
  devise_for :employees, controllers: { sessions: 'employees/sessions',
                                        registrations: 'employees/registrations' }

  devise_for :managers, controllers: { sessions: 'managers/sessions',
                                       registrations: 'managers/registrations' }

  devise_for :system_managers, controllers: { sessions: 'managers/sessions'}
  as :system_manager do
    get 'system_managers/edit' => 'devise/registrations#edit', :as => 'edit_system_manager_registration'
    put 'system_managers' => 'devise/registrations#update', :as => 'system_manager_registration'
  end

  devise_for :customers
  devise_for :providers, controllers: { sessions: 'providers/sessions',
                                        registrations: 'providers/registrations' }

  resources :seats
  resources :drinks
  resources :foods
  resources :restaurants
  resources :orders
  resources :offers

  post 'home_page/customer_home/send_friend_request',    as: 'send_friend_request'
  post 'home_page/customer_home/accept_friend_request',  as: 'accept_friend_request'
  post 'home_page/customer_home/decline_friend_request', as: 'decline_friend_request'
  delete 'home_page/customer_home/remove_friend',        as: 'remove_friend'

  authenticated :customer do
    root 'home_page/customer_home#index'
  end

  authenticated :manager do
    root 'home_page/manager_home#index'
  end

  authenticated :system_manager do
    root 'home_page/system_manager_home#index'
  end

  authenticated :employee do
    root 'home_page/employee_home#index'
  end

  authenticated :provider do
    root 'home_page/provider_home#index'
  end

  root 'landing_page#index'
end
