require 'rails_helper'

RSpec.describe Customer, type: :model do

  describe 'Validations' do
    let!(:customer) { build(:customer) }

    context 'with valid attributes' do
      it 'is valid' do
        expect(customer).to be_valid
      end
    end

    context 'with missing firstname' do
      it 'is invalid' do
        customer.firstname = nil
        expect(customer).to_not be_valid
      end
    end

    context 'with missing lastname' do
      it 'is invalid' do
        customer.lastname = nil
        expect(customer).to_not be_valid
      end
    end

    context 'with firstname too short' do
      customer.firstname = 'A'
      expect(customer).to_not be_valid

      customer.firstname = 'John'
      expect(customer).to be_valid
    end

    context 'with firstname too long' do
      customer.firstname = 'John' * 8
      expect(customer).to_not be_valid

      customer.firstname = 'John'
      expect(customer).to be_valid
    end

    context 'with lastname too short' do
      customer.lastname = 'A'
      expect(customer).to_not be_valid

      customer.lastname = 'John'
      expect(customer).to be_valid
    end

    context 'with lastname too long' do
      customer.lastname = 'John' * 8
      expect(customer).to_not be_valid

      customer.lastname = 'John'
      expect(customer).to be_valid
    end

    context 'with blank firstname' do
      it 'is invalid' do
        customer.firstname = ''
        expect(customer).to_not be_valid
        expect(customer.errors).to include("Firstname can't be blank")
      end
    end

    context 'with blank lastname' do
      it 'is invalid' do
        customer.lastname = ''
        expect(customer).to_not be_valid
        expect(customer.errors).to include("Lastname can't be blank")
      end
    end
  end
end
