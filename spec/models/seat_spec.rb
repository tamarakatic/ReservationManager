require 'rails_helper'

RSpec.describe Seat, type: :model do
  describe 'Associations' do
    it { should have_one(:restaurant) }
  end

  describe 'Validations' do
    let!(:seat) { create(:seat, number: 2) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(seat).to be_valid
      end
    end

    context 'with number already taken' do
      it 'is invalid' do
        expect { create(:seat, number: 2) }.to raise_error ActiveRecord::RecordInvalid
      end
    end

    context 'with missing number' do
      it 'is invalid' do
        seat.number = nil
        expect(seat).to_not be_valid
      end
    end

    context 'with missing area' do
      it 'is invalid' do
        seat.area = nil
        expect(seat).to_not be_valid
      end
    end

    context 'with number less than 1' do
      it 'is invalid' do
        seat.number = -1
        expect(seat).to_not be_valid
      end
    end

    context 'with number bigger than 100' do
      it 'is invalid' do
        seat.number = 102
        expect(seat).to_not be_valid
      end
    end

    context 'with area length less than 2' do
      it 'is invalid' do
        seat.area = 'A'
        expect(seat).to_not be_valid
      end
    end

    context 'with area length more than 30' do
      it 'is invalid' do
        seat.area = 'Abcd' * 8
        expect(seat).to_not be_valid
      end
    end

    context 'with blank area' do
      it 'is invalid' do
        seat.area = '    '
        expect(seat).to_not be_valid
        expect(seat.errors[:area]).to include("can't be blank")
      end
    end
  end
end
