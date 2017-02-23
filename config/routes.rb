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
  as :customer do
    get    "friends"          => "customers/friends#index"
    get    "search_friends"   => "customers/friends#search"
    get    "pending_requests" => "customers/friends#pending"
    get    "find_friends"     => "customers/friends#find"
    post   "send_request"     => "customers/friends#send_request"
    post   "accept_request"   => "customers/friends#accept_request"
    post   "decline_request"  => "customers/friends#decline_request"
    delete "remove_friend"    => "customers/friends#remove"
  end

  devise_for :providers, controllers: { sessions: 'providers/sessions',
                                        registrations: 'providers/registrations' }

  resources :seats
  resources :drinks
  resources :foods
  resources :restaurants
  resources :orders
  resources :offers
  resources :number_of_seats

  get 'profiles/employee_profile' => 'profiles/employee_profile#index', :as => 'employee_profile'
  get 'profiles/manager_profile' => 'profiles/manager_profile#index', :as => 'manager_profile'

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
