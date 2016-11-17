class Manager < ApplicationRecord
  has_many :providers, dependent: :destroy
  has_many :employees, dependent: :destroy

  validates :firstname, :presence => true,
                        :length => { :in => 2..30 },
                        :allow_blank => false

  validates :lastname, :presence => true,
                        :length => { :in => 2..30 },
                        :allow_blank => false

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
