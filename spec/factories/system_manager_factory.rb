FactoryGirl.define do
	factory :system_manager do
		firstname 'Zika'
		lastname 'Zikic'
		email 'zika@gmail.com'
		password 'zikaadmin'
		password_confirmation 'zikaadmin'
		confirmed_at Time.now
	end
end