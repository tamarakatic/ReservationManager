FactoryGirl.define do
  factory :order_item do
    item "Kupus"
    quantity "20"
    unit_of_measure "kg"
    order
  end
end
