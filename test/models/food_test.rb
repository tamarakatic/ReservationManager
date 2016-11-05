require 'test_helper'

class FoodTest < ActiveSupport::TestCase

  test "the food attribute for name must be the unique" do
    food = Food.new(description: "ssdadsads",
                    price: 10,
                    restaurant: restaurants(:one))
    food.name = "Salata"
    assert food.invalid?
    assert_equal ["has already been taken"], food.errors[:name]

    food.name = "Pilece belo"
    assert food.valid?
  end

  test "food price must be positive" do
    food = Food.new(name: "Supa",
                    restaurant: restaurants(:one),
                    description: "dfsdfdfdsf")
    food.price = -1
    assert food.invalid?
    assert_equal ["must be greater than or equal to 0.01"], food.errors[:price]

    food.price = 5
    assert food.valid?
  end

end
