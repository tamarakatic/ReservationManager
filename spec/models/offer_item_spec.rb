require 'rails_helper'

RSpec.describe OfferItem, type: :model do
  describe 'Associations' do
    it { should belong_to(:offer)}
    it { should have_one(:order_item)}
  end

  describe 'Validations' do
    let!(:offer_item) { build(:offer_item, price: 9.99 )}

    context 'with valid attributes' do
      it 'is valid' do
        expect(offer_item).to be_valid
      end
    end

    context 'with missing quantity' do
      it 'is invalid' do
        offer_item.price = nil
        expect(offer_item).to_not be_valid
      end
    end

    context 'with negative quantity' do
      it 'is invalid' do
        offer_item.price = -1
        expect(offer_item).to_not be_valid
      end
    end
  end
end
