require 'test_helper'

class SeatTest < ActiveSupport::TestCase
  test "number must be =>1 and <=100" do
    seat = Seat.new(area: "Garden",
                    restaurant: restaurants(:one))
    seat.number = 0
    assert seat.invalid?
    assert_equal ["must be greater than or equal to 1"], seat.errors[:number]

    seat.number = 50
    assert seat.valid?

    seat.number = 200
    assert seat.invalid?
    assert_equal ["must be less than or equal to 100"], seat.errors[:number]
  end

  test "number must be unique" do
    seat = Seat.new(area: "Garden",
                    restaurant: restaurants(:one))
    seat.number = 1
    assert seat.invalid?
    assert_equal ["has already been taken"], seat.errors[:number]

    seat.number = 42
    assert seat.valid?
  end

  test "area length must be >=2 and <= 30" do
    seat = Seat.new(area: "Garden" * 6,
                    number: 42,
                    restaurant: restaurants(:one))

    assert seat.invalid?
    assert_equal ["is too long (maximum is 30 characters)"], seat.errors[:area]

    seat.area = "A"

    assert seat.invalid?
    assert_equal ["is too short (minimum is 2 characters)"], seat.errors[:area]

    seat.area = "VIP"
    assert seat.valid?
  end

end
