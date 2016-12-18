FactoryGirl.define do
  factory :restaurant do
    title 'Black Swan'
    description "Very famous restaurant,
                it's in top 5 restaurant in the city"
    manager
    food
    drink
    seat
  end
end
