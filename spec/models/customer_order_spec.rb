require 'rails_helper'

RSpec.describe CustomerOrder, type: :model do
  describe 'Associations' do
    it { should have_many(:customer_order_drinks).dependent(:destroy) }
    it { should have_many(:drinks).through(:customer_order_drinks) }
    it { should have_many(:customer_order_foods).dependent(:destroy) }
    it { should have_many(:foods).through(:customer_order_foods) }
    it { should have_many(:customer_order_seats).dependent(:destroy) }
    it { should have_many(:seats).through(:customer_order_seats) }
  end
end
