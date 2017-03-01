class Drink < ApplicationRecord
  belongs_to :restaurant
  has_many :customer_order_drinks, :dependent => :destroy
  has_many :customer_orders, :through => :customer_order_drinks

  has_many :drink_reviews
  has_many :drinks, :through => :drink_reviews

  validates :name, presence: true,
                   uniqueness: true,
                   length: { in: 2..30 },
                   allow_blank: false

  validates :description, presence: true,
                          length: { maximum: 300 },
                          allow_blank: false

  validates :price, presence: true,
                    numericality: { greater_than_or_equal_to: 0.01 }
end
