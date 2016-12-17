FactoryGirl.define do
  factory :manager do
    firstname 'Misa'
    lastname 'Misic'
    email 'misa@gmail.com'
    password 'misamisic'
    password_confirmation 'misamisic'
    confirmed_at Time.now
  end
end
