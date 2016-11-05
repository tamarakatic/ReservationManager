require 'test_helper'

class DrinkTest < ActiveSupport::TestCase

  test "the name should be unique" do
    drink = Drink.new(description:  "Test",
                      price:        42,
                      restaurant:   restaurants(:one))

    drink.name = "MyString"

    assert drink.invalid?
    assert_equal ["has already been taken"], drink.errors[:name]

    drink.name = "Test"
    assert drink.valid?
  end

  test "the attributes should be present" do
    drink = Drink.new

    assert drink.invalid?
    assert_includes drink.errors[:name], "can't be blank"
    assert_includes drink.errors[:description], "can't be blank"
    assert_includes drink.errors[:price], "can't be blank"

    drink.name        = "Test"
    drink.description = "Test"
    drink.price       = 42
    drink.restaurant  = restaurants(:one)

    assert drink.valid?
  end

  test "the price should be positive number" do
    drink = Drink.new(name:         "Test",
                      description:  "Test",
                      restaurant:   restaurants(:one))

    drink.price = -1

    assert drink.invalid?
    assert_equal ["must be greater than or equal to 0.01"], drink.errors[:price]

    drink.price = 5
    assert drink.valid?
  end

  test "the length of name and description must be in given interval" do
    drink = Drink.new(name:         "Test" * 8,
                      description:  "Test" * 80,
                      price:        42,
                      restaurant:   restaurants(:one))

    assert drink.invalid?
    assert_equal ["is too long (maximum is 30 characters)"], drink.errors[:name]
    assert_equal ["is too long (maximum is 300 characters)"], drink.errors[:description]

    drink.name = "A"
    assert drink.invalid?
    assert_equal ["is too short (minimum is 2 characters)"], drink.errors[:name]

    drink.name        = "Test"
    drink.description = "Test"

    assert drink.valid?
  end

end
