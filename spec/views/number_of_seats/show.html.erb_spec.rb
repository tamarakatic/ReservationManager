require 'rails_helper'

RSpec.describe "number_of_seats/show", type: :view do
  before(:each) do
    @number_of_seat = assign(:number_of_seat, NumberOfSeat.create!())
  end

  it "renders attributes in <p>" do
    render
  end
end
