require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "Associations" do
    it { should have_many(:reservations) }
    it { should have_many(:reservation_invitations) }
  end

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
      it 'is invalid' do
        customer.firstname = 'A'
        expect(customer).to_not be_valid

        customer.firstname = 'John'
        expect(customer).to be_valid
      end
    end

    context 'with firstname too long' do
      it 'is invalid' do
        customer.firstname = 'John' * 8
        expect(customer).to_not be_valid

        customer.firstname = 'John'
        expect(customer).to be_valid
      end
    end

    context 'with lastname too short' do
      it 'is invalid' do
        customer.lastname = 'A'
        expect(customer).to_not be_valid

        customer.lastname = 'John'
        expect(customer).to be_valid
      end
    end

    context 'with lastname too long' do
      it 'is invalid' do
        customer.lastname = 'John' * 8
        expect(customer).to_not be_valid

        customer.lastname = 'John'
        expect(customer).to be_valid
      end
    end

    context 'with blank firstname' do
      it 'is invalid' do
        customer.firstname = '    '
        expect(customer).to_not be_valid
        expect(customer.errors[:firstname]).to include("can't be blank")
      end
    end

    context 'with blank lastname' do
      it 'is invalid' do
        customer.lastname = '    '
        expect(customer).to_not be_valid
        expect(customer.errors[:lastname]).to include("can't be blank")
      end
    end
  end

  describe 'Friendships' do
    let!(:user) { create(:customer) }
    let!(:friend) { create(:customer, email: 'johndoe@gmail.com', firstname: 'John', lastname: 'Doe')}

    it 'can make friend request' do
      user.friend_request(friend)

      expect(friend.requested_friends.first).to eq user
    end

    it 'can accept friend request' do
      user.friend_request(friend)
      expect(friend.requested_friends.first).to eq user

      friend.accept_request(user)
      expect(friend.friends_with?(user)).to be_truthy
      expect(user.friends_with?(friend)).to be_truthy
    end

    it 'can decline friend request' do
      user.friend_request(friend)
      expect(friend.requested_friends.first).to eq user

      friend.decline_request(user)
      expect(friend.friends_with?(user)).to be_falsy
    end

    it 'can remove friend' do
      user.friend_request(friend)
      friend.accept_request(user)

      expect(friend.friends_with?(user)).to be_truthy
      expect(user.friends_with?(friend)).to be_truthy

      user.remove_friend(friend)

      expect(friend.friends_with?(user)).to be_falsy
      expect(user.friends_with?(friend)).to be_falsy
    end

  end
end
