class Customer < ApplicationRecord
  validates :firstname, :presence => true,
                        :allow_blank => false,
                        :length => { :in => 2..30 }

  validates :lastname, :presence => true,
                       :allow_blank => false,
                       :length => { :in => 2..30 }

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
