FactoryGirl.define do
  factory :customer do
    firstname 'John'
    lastname 'Doe'
    email 'john@gmail.com'
    password 'qwerty'
    password_confirmation 'qwerty'
  end
end
