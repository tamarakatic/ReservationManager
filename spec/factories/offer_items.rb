FactoryGirl.define do
  factory :offer_item do
    offer
    order_item
    price 42
  end
end
