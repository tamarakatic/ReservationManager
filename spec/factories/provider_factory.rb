FactoryGirl.define do
	factory :provider do
		firstname 'John'
		lastname 'Doe'
		email 'JohnProvider@gmail.com'
		password 'providerDoe'
		password_confirmation 'providerDoe'
		confirmed_at Time.now
		manager
	end
end