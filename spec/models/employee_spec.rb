require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'Associations' do
    it { should belong_to(:manager) }
  end

  describe 'Validations' do
    let!(:employee) { build(:employee) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(employee).to be_valid
      end
    end

    context 'with short firstaname length' do
      it 'is invalid' do
        employee.firstname = 'A'
        expect(employee).to_not be_valid

        employee.firstname = 'Ana'
        expect(employee).to be_valid
      end
    end

    context 'with long firstname length' do
      it 'is invalid' do
        employee.firstname = 'Aaaa' * 8
        expect(employee).to_not be_valid
      end
    end

    context 'with short lastname length' do
      it 'is invalid' do
        employee.lastname = 'A'
        expect(employee).to_not be_valid
      end
    end

    context 'with long lastname length' do
      it 'is invalid' do
        employee.lastname = 'Aaaa' * 8
        expect(employee).to_not be_valid
      end
    end

    context 'with missing firstname' do
      it 'is invalid' do
        employee.firstname = nil
        expect(employee).to_not be_valid
      end
    end

    context 'with missing lastname' do
      it 'is invalid' do
        employee.lastname = nil
        expect(employee).to_not be_valid
      end
    end

    context 'with too small shoe_size number' do
      it 'is invalid' do
        employee.shoe_size = 32
        expect(employee).to_not be_valid

        employee.shoe_size = 49
        expect(employee).to be_valid
      end
    end

    context 'with too big shoe_size number' do
      it 'is invalid' do
        employee.shoe_size = 50
        expect(employee).to_not be_valid
      end
    end

    context 'with age number less than 18' do
      it 'is invalid' do
        employee.birth_date = Date.new(2000, 12, 28)
        expect(employee).to_not be_valid

        employee.birth_date = Date.new(1990, 12, 28)
        expect(employee).to be_valid
      end
    end
  end
end
