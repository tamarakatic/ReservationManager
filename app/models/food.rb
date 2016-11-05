class Food < ApplicationRecord
  belongs_to :restaurant

  validates :name, :description, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0.01 }
  validates :name, uniqueness: true
end
