# Use rails db:reset

manager = Manager.create!(firstname: 'Pera',
                         lastname: 'Peric',
                         email: 'peric@gmail.com',
                         password: 'peraperic',
                         password_confirmation: 'peraperic',
                         confirmed_at: Time.now)

manager.employees.create!(firstname: 'Ana',
                         lastname: 'Spasic',
                         email: 'ana@gmail.com',
                         password: 'anaspasic',
                         password_confirmation: 'anaspasic',
                         confirmed_at: Time.now,
                         role: 'waiter',
                         clothing_size: 'S',
                         birth_date: Date.new(1994, 5, 5),
                         shoe_size: 42)

manager.restaurant = Restaurant.create!(manager_id: manager.id,
                                        title: 'Black Swan',
                                        description: "It's in top 5 restaurant in the city")

manager.restaurant.foods.create!(name: 'Cookie',
                                description: 'Delicious sweet food',
                                price: 4.0)

manager.restaurant.drinks.create!(name: 'Rakija',
                                 description: 'Strong drink',
                                 price: 10.0)

manager.restaurant.seats.create!(number: 3,
                                area: 'Garden I')

manager.restaurant.providers.create!(firstname: 'Misa',
                                     lastname: 'Misic',
                                     email: 'misko@gmail.com',
                                     password: 'misamisic',
                                     password_confirmation: 'misamisic',
                                     confirmed_at: Time.now)

SystemManager.create!(firstname: 'Admin',
                     lastname: 'Admin',
                     email: 'admin@gmail.com',
                     password: 'sistem',
                     password_confirmation: 'sistem')
