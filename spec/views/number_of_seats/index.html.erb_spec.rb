require 'rails_helper'

RSpec.describe "number_of_seats/index", type: :view do
  before(:each) do
    assign(:number_of_seats, [
      NumberOfSeat.create!(),
      NumberOfSeat.create!()
    ])
  end

  it "renders a list of number_of_seats" do
    render
  end
end
