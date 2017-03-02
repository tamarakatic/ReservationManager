Rails.application.routes.draw do

  namespace :profiles do
    get 'bartender_orders/index'
  end

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

  namespace :customers do
    get    "reservations/history"
    get    "reservations/index"
    get    "reservations/orders"
    get    "reservations/new"
    get    "reservations/available_tables"
    post   "reservations/create"
    post   "reservations/orders"
    post   "reservations/accept"
    post   "reservations/decline"
    delete "reservations/cancel"
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

  get "list_food" => "restaurants#list_food"

  get "list_drink" => "restaurants#list_drink"

  get "list_seat" => "restaurants#list_seat"

  get "visit_chart" => "restaurants#visit_chart"

  get "review_mark" => "restaurants#review_mark"

  get "income" => "restaurants#income"

  get "list_provider" => "home_page/manager_home#list_provider"

  get "list_order" => "home_page/manager_home#list_order"

  get "list_offer" => "home_page/manager_home#list_offer"

  get 'profiles/employee_calendar' => 'profiles/employee_calendar#index', :as => 'employee_calendar'
  get 'profiles/employee_reon'     => 'profiles/employee_reon#index',     :as => 'employee_reon'
  get 'profiles/employee_reon/seats' => 'profiles/employee_reon#seats'
  get 'profiles/waiter_orders'     => 'profiles/waiter_orders#index',     :as => 'waiter_orders'
  put 'profiles/waiter_orders'     => 'profiles/waiter_orders#finish'

  get 'profiles/cook_orders'       => 'profiles/cook_orders#index',       :as => 'cook_orders'
  put 'profiles/cook_orders/prepare' => 'profiles/cook_orders#setPrepare'
  put 'profiles/cook_orders/finish'  => 'profiles/cook_orders#finish'

  get 'profiles/bartender_orders'  => 'profiles/bartender_orders#index',  :as => 'bartender_orders'
  put 'profiles/bartender_orders/prepare'  => 'profiles/bartender_orders#prepare'
  put 'profiles/bartender_orders/finish'   => 'profiles/bartender_orders#finish'

  get 'table_orders'               => 'table_orders#index'

  put 'table_orders/foods'         => 'table_orders#add_foods'
  delete 'table_orders'            => 'table_orders#delete_food'
  put 'table_orders/exchange'      => 'table_orders#exchange_food'
  post 'table_orders/notify_cook'  => 'table_orders#notify_cook'
  post 'table_orders/notify_bartender'  => 'table_orders#notify_bartender'

  put 'table_orders/drinks'        => 'table_orders#add_drinks'
  delete 'table_orders/remove_drinks'    => 'table_orders#delete_drink'
  put 'table_orders/exchange_drink'     => 'table_orders#exchange_drink'

  get 'profiles/order_histories'   => 'profiles/order_histories#index',   :as => 'order_histories'

  get 'employee/notifications'     => 'home_page/employee_home#notifications'

  get 'customers/reservations/reservation_reviews' => 'customers/reservations/reservation_reviews#index', :as => 'reservation_reviews'
  post 'reservation_reviews/restaurant' => 'customers/reservations/reservation_reviews#restaurant_review', :as => 'reservation_reviews/restaurant'
  post 'reservation_reviews/foods' => 'customers/reservations/reservation_reviews#foods_review', :as => 'reservation_reviews/foods'
  post 'reservation_reviews/drinks' => 'customers/reservations/reservation_reviews#drinks_review', :as => 'reservation_reviews/drinks'

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
