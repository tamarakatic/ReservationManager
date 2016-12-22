FactoryGirl.define do
  factory :provider do
    firstname 'John'
    lastname 'Doe'
    email 'johnprovider@hotmail.com'
    password 'providerDoe'
    password_confirmation 'providerDoe'
    confirmed_at Time.now
  end
end
