class RestaurantProvider < ApplicationRecord
  belongs_to :provider
  belongs_to :restaurant
end
