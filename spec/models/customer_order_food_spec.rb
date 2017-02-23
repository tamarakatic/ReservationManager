require 'rails_helper'

RSpec.describe CustomerOrderFood, type: :model do
  describe 'Associations' do
    it { should belong_to(:food) }
    it { should belong_to(:customer_order) }
  end
end
