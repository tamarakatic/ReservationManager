require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe 'Associations' do
  	it { should belong_to(:manager) }
  end

  describe 'Validations' do
  	let!(:provider) { build(:provider) }

  	context 'with valid attributes' do
  		it 'is valid'	do
  			expect(provider).to be_valid
  		end
  	end

  	context 'with misssing firstname' do
  		it 'is invalid' do
  			provider.firstname = nil
  			expect(provider).to_not be_valid
  		end
  	end

  	context 'with missing lastname' do
  		it 'is invalid' do
  			provider.lastname = nil
  			expect(provider).to_not be_valid
  		end
  	end

  	context 'with firstname too short' do
  		it 'is invalid' do
  			provider.firstname = 'P'
  			expect(provider).to_not be_valid

  			provider.firstname = 'John'
  			expect(provider).to be_valid
  		end
  	end

  	context 'with firstname too long' do
  		it 'is invalid' do
  			provider.firstname = 'John' * 8
  			expect(provider).to_not be_valid

  			provider.firstname = 'John'
  			expect(provider).to be_valid
  		end
  	end

  	context 'with lastname too short' do
  		it 'is invalid' do
  			provider.lastname = 'D'
  			expect(provider).to_not be_valid

  			provider.lastname = 'Doe'
  			expect(provider).to be_valid
  		end
  	end

  	context 'with lastname too long' do
  		it 'is invalid' do
  			provider.lastname = 'Doe' * 11
  			expect(provider).to_not be_valid

  			provider.lastname = 'Doe'
  			expect(provider).to be_valid
  		end
  	end

  	context 'with blank firstname' do
  		it 'is invalid' do
  			provider.firstname = '   '
  			expect(provider).to_not be_valid
  			expect(provider.errors[:firstname]).to include("can't be blank")
  		end
  	end

  	context 'with blank lastname' do
  		it 'is invalid' do
  			provider.lastname = '   '
  			expect(provider).to_not be_valid
  			expect(provider.errors[:lastname]).to include("can't be blank")
  		end
  	end
  end
end
