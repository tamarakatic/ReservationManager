require 'rails_helper'

RSpec.describe CustomerOrderDrink, type: :model do
  describe 'Associations' do
    it { should belong_to(:drink) }
    it { should belong_to(:customer_order) }
  end
end
