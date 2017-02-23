require 'rails_helper'

RSpec.describe CustomerOrderSeat, type: :model do
  describe 'Associations' do
    it { should belong_to(:seat) }
    it { should belong_to(:customer_order) }
  end
end
