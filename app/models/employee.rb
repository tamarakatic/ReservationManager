class Employee < ApplicationRecord
  enum role: ['bartender', 'waiter', 'cook']
  enum clothing_size: ['XS', 'S', 'M', 'L', 'XL', 'XXL']
  
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable
end
