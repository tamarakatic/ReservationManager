require 'rails_helper'

RSpec.describe OrderItem, type: :model do
  describe 'Associations' do
    it { should belong_to(:order)}
  end

  describe 'Validations' do
    let!(:order_item) { build(:order_item, item: 'Kupus' )}

    context 'with valid attributes' do
      it 'is valid' do
        expect(order_item).to be_valid
      end
  end

    context 'with missing item' do
      it 'is invalid' do
        order_item.item = nil
        expect(order_item).to_not be_valid
      end
    end

    context 'with blank name' do
      it 'is invalid' do
        order_item.item = '    '
        expect(order_item).to_not be_valid
        expect(order_item.errors[:item]).to include("can't be blank")
      end
    end

    context 'with item too short' do
      it 'is invalid' do
        order_item.item = 'A'
        expect(order_item).to_not be_valid
      end
    end

    context 'with item too long' do
      it 'is invalid' do
        order_item.item = 'Abcdef' * 8
        expect(order_item).to_not be_valid
      end
    end

    context 'with missing quantity' do
      it 'is invalid' do
        order_item.quantity = nil
        expect(order_item).to_not be_valid
      end
    end

    context 'with negative quantity' do
      it 'is invalid' do
        order_item.quantity = -1
        expect(order_item).to_not be_valid
      end
    end

    context 'with missing unit_of_measure' do
      it 'is invalid' do
        order_item.unit_of_measure = nil
        expect(order_item).to_not be_valid
      end
    end

    context 'with blank unit_of_measure' do
      it 'is invalid' do
        order_item.unit_of_measure = '    '
        expect(order_item).to_not be_valid
        expect(order_item.errors[:unit_of_measure]).to include("can't be blank")
      end
    end

    context 'with unit_of_measure too long' do
      it 'is invalid' do
        order_item.unit_of_measure = 'Abcdef' * 2
        expect(order_item).to_not be_valid
      end
    end
  end
end
