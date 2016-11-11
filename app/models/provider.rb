class Provider < ApplicationRecord
  belongs_to :manager
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
