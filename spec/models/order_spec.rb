require 'rails_helper'

RSpec.describe Order, type: :model do
  describe 'Associations' do
    it { should belong_to(:restaurant)}
  end

  describe 'Validations' do
    let!(:order) { build(:order, active_from: Time.now )}

    context 'with valid attributes' do
      it 'is valid' do
        expect(order).to be_valid
      end
    end
  end
end
