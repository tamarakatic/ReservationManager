require 'rails_helper'

RSpec.describe OfferItem, type: :model do
  it { should belong_to(:offer) }
  it { should belong_to(:order_item) }

  describe "attributes" do
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price) }
    it { should_not allow_value(-1).for(:price) }
  end
end
