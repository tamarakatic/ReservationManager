require 'test_helper'

class RestaurantTest < ActiveSupport::TestCase
  test "the title must be unique" do
    restaurant = Restaurant.new(description: "Test")
    restaurant.title = "MyString"

    assert restaurant.invalid?
    assert_equal ["has already been taken"], restaurant.errors[:title]

    restaurant.title = "Test"
    assert restaurant.valid?
  end

  test "the attributes must be present" do
    restaurant = Restaurant.new

    assert restaurant.invalid?
    assert restaurant.errors[:title].any?
    assert restaurant.errors[:description].any?

    restaurant.title       = "Test"
    restaurant.description = "Test"

    assert restaurant.valid?
  end

  test "the title and description must be in given interval" do
    restaurant = Restaurant.new(title:        "Test" * 8,
                                description:  "Test" * 80)

    assert restaurant.invalid?
    assert_equal ["is too long (maximum is 30 characters)"], restaurant.errors[:title]
    assert_equal ["is too long (maximum is 300 characters)"], restaurant.errors[:description]

    restaurant.title = "A"
    assert restaurant.invalid?
    assert_equal ["is too short (minimum is 2 characters)"], restaurant.errors[:title]

    restaurant.title       = "Test"
    restaurant.description = "Test"

    assert restaurant.valid?
  end
end
