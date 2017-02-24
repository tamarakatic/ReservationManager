FactoryGirl.define do
  factory :order do
    active_from Time.now
    active_till Time.now + 10.days
    restaurant
  end
end
