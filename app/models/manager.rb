class Manager < ApplicationRecord
  has_many :providers, dependent: :destroy
  has_many :employees, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
end
