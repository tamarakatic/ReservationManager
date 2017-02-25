class Customer < ApplicationRecord
  has_friendship

  validates :firstname, :presence => true,
                        :allow_blank => false,
                        :length => { :in => 2..30 }

  validates :lastname, :presence => true,
                       :allow_blank => false,
                       :length => { :in => 2..30 }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  def search_friends(params, type)
    friends = type == :old_friends ? self.friends : self.friendables

    unless params.empty?
      friends.where("firstname ILIKE ? or lastname ILIKE ?", "%#{params}%", "%#{params}%")
    else
      friends
    end
  end

  def friendables
    current_friends  = self.friends.map { |f| f.id } << self.id
    current_friends += self.pending_friends.map { |f| f.id }

    Customer.where.not(:id => current_friends )
  end

end
