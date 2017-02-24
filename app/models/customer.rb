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

  def search_friends(params)
    unless params.empty?
      self.friends.where("firstname ILIKE ? or lastname ILIKE ?", "%#{params}%", "%#{params}%")
    else
      self.friends
    end
  end
end
