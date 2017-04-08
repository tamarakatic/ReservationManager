require "rails_helper"

RSpec.describe CustomerOrderSeat, type: :model do
  describe "associations" do
    it { should belong_to(:number_of_seat) }
    it { should belong_to(:customer_order) }
  end
end
