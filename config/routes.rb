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

  authenticated :customer do
    root 'home_page/customer_home#index'
  end

  post 'home_page/customer_home/send_friend_request',    as: 'send_friend_request'
  post 'home_page/customer_home/accept_friend_request',  as: 'accept_friend_request'
  post 'home_page/customer_home/decline_friend_request', as: 'decline_friend_request'
  delete 'home_page/customer_home/remove_friend',        as: 'remove_friend'

  authenticated :employee do
    root 'home_page/employee_home#index'
  end

  authenticated :manager do
    root 'home_page/manager_home#index'
  end

  root 'landing_page#index'
end
