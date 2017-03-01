Rails.application.routes.draw do
  get 'employee_shift/index'

  mount ActionCable.server => '/cable'

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
  resources :employee_shifts


  get 'profiles/employee_profile'  => 'profiles/employee_profile#index',  :as => 'employee_profile'
  get 'profiles/manager_profile'   => 'profiles/manager_profile#index',   :as => 'manager_profile'


  get "accept_offer" => "orders#accept_offer"

  get 'profiles/employee_calendar' => 'profiles/employee_calendar#index', :as => 'employee_calendar'
  get 'profiles/employee_reon'     => 'profiles/employee_reon#index',     :as => 'employee_reon'
  get 'profiles/employee_reon/seats' => 'profiles/employee_reon#seats'
  get 'profiles/waiter_orders'     => 'profiles/waiter_orders#index',     :as => 'waiter_orders'
  get 'profiles/cook_orders'       => 'profiles/cook_orders#index',       :as => 'cook_orders'

  get 'table_orders'               => 'table_orders#index'

  put 'table_orders/foods'         => 'table_orders#add_foods'
  delete 'table_orders'            => 'table_orders#delete_food'
  put 'table_orders/exchange'      => 'table_orders#exchange_food'

  put 'table_orders/drinks'        => 'table_orders#add_drinks'
  delete 'table_orders/remove_drinks'    => 'table_orders#delete_drink'
  put 'table_orders/exchange_drink'     => 'table_orders#exchange_drink'

  get 'profiles/order_histories'   => 'profiles/order_histories#index',   :as => 'order_histories'

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
