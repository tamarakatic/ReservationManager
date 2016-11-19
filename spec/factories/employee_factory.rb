FactoryGirl.define do
  factory :employee do
    firstname 'Pera'
    lastname 'Peric'
    role 'waiter'
    clothing_size 'S'
    birth_date Date.new(1994, 5, 5)
    shoe_size 42
    email 'pera@gmail.com'
    password 'peraperic'
    password_confirmation 'peraperic'
    manager
  end
end
