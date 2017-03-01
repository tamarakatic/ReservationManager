FactoryGirl.define do
  factory :reserved_table do
    duration       2
    date           DateTime.now
    reservation    :strategy => :build
    number_of_seat :strategy => :build
  end
end
