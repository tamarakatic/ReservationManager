FactoryGirl.define do
  factory :employee do
    firstname 'Pera'
    lastname 'Peric'
    clothing_size 'S'
    birth_date Date.new(1994, 5, 5)
    shoe_size 42
    email 'pera@gmail.com'
    password 'peraperic'
    password_confirmation 'peraperic'
    confirmed_at Time.now
    manager
  end
end
