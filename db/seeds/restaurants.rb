# Restaurant.delete_all
# CustomerOrder.delete_all
# CustomerOrderDrink.delete_all
# CustomerOrderFood.delete_all
# CustomerOrderSeat.delete_all
# ServingTime.delete_all

pera = Manager.create!(:firstname             => "Pera",
                       :lastname              => "Peric",
                       :email                 => "peric@gmail.com",
                       :password              => "peraperic",
                       :password_confirmation => "peraperic",
                       :confirmed_at          => Time.now)

pera.create_restaurant!(:title       => "Black Swan",
                        :description => "Our impressive menu of nationally renowned dry aged " +
                                        "steaks and the freshest of seafood will ignite your " +
                                        "culinary imagination as our award-winning wine list " +
                                        "of more than 5,000 bottles awakens your inner sommelier")

steak = pera.restaurant.foods.create!(:name        => "Steak Tartare",
                              :description => "Dry aged steak with avocado.",
                              :price       => 45.0,
                              :food_type   => "RoastMeal")

becka = pera.restaurant.foods.create!(:name        => "Becka snicla",
                              :description => "Quality only.",
                              :price       => 5.0,
                              :food_type   => "RoastMeal")

rakija = pera.restaurant.drinks.create!(:name        => "Rakija",
                               :description => "Strong alcholic beverage",
                               :price       => 10.0)

viski = pera.restaurant.drinks.create!(:name        => "Jack Daniels",
                               :description => "Top notch scocht",
                               :price       => 50.0)

ana = pera.employees.create!(:firstname             => "Ana",
                       :lastname              => "Spasic",
                       :email                 => "ana@gmail.com",
                       :password              => "anaspasic",
                       :password_confirmation => "anaspasic",
                       :password_changed      => true,
                       :confirmed_at          => Time.now,
                       :clothing_size         => "S",
                       :birth_date            => Date.new(1994, 5, 5),
                       :shoe_size             => 42,
                       :type                  => 'Waiter')

pera.employees.create!(:firstname             => "Djole",
                       :lastname              => "Djokic",
                       :email                 => "djole@gmail.com",
                       :password              => "djoledjokic",
                       :password_confirmation => "djoledjokic",
                       :confirmed_at          => Time.now,
                       :clothing_size         => "S",
                       :birth_date            => Date.new(1989, 3, 7),
                       :shoe_size             => 43,
                       :speciality            => "RoastMeal",
                       :type                  => 'Cook')

pera.employees.create!(:firstname             => "Misa",
                       :lastname              => "Macak",
                       :email                 => "somi@gmail.com",
                       :password              => "somimacak",
                       :password_confirmation => "somimacak",
                       :confirmed_at          => Time.now,
                       :clothing_size         => "S",
                       :birth_date            => Date.new(1989, 3, 7),
                       :shoe_size             => 41,
                       :type                  => 'Bartender')

milos = pera.employees.create!(:firstname             => "Milos",
                       :lastname              => "Ivic",
                       :email                 => "milos@gmail.com",
                       :password              => "milosivic",
                       :password_confirmation => "milosivic",
                       :confirmed_at          => Time.now,
                       :clothing_size         => "M",
                       :birth_date            => Date.new(1989, 3, 7),
                       :shoe_size             => 44,
                       :type                  => 'Waiter')

pera.restaurant.seats.create!(:area => "Garden I")
pera.restaurant.seats.create!(:area => "Garden II")
garden = pera.restaurant.seats.create!(:area => "Garden III")

pera.restaurant.seats.each.with_index(1) do |seat, iteration|
  Array.new(5) { rand(1...8) }.each.with_index(1) do |seats, number|
    seat.number_of_seats.create!(:number => number + iteration * 5, :seatstable => seats)
  end
end

pera.restaurant.providers.create!(:firstname             => "Misa",
                                  :lastname              => "Misic",
                                  :email                 => "misko@gmail.com",
                                  :password              => "misamisic",
                                  :password_confirmation => "misamisic",
                                  :password_changed      => true,
                                  :confirmed_at          => Time.now)

pera.restaurant.providers.create!(:firstname             => "Slade",
                                  :lastname              => "Willson",
                                  :email                 => "slade@gmail.com",
                                  :password              => "sladeslade",
                                  :password_confirmation => "sladeslade",
                                  :password_changed      => true,
                                  :confirmed_at          => Time.now)

customer_order = CustomerOrder.create!(:status           => "Active",
                                       :order_time       => DateTime.new(2017, 2, 2, 10, 10, 0, Rational(-0,24)))
customer_order.foods << steak
customer_order.foods << becka
customer_order.drinks << rakija
customer_order.drinks << viski
customer_order.number_of_seats << garden.number_of_seats[0]

customer_order_again = CustomerOrder.create!(:status           => "Finished",
                                             :order_time       => DateTime.new(2017, 2, 2, 10, 10, 0, Rational(-0,24)))
customer_order_again.foods << steak
customer_order_again.foods << becka
customer_order_again.drinks << rakija
customer_order_again.drinks << viski
customer_order_again.number_of_seats << garden.number_of_seats[0]

ServingTime.create!(:employee_id => ana.id,
                    :customer_order_id => customer_order.id)

ServingTime.create!(:employee_id => milos.id,
                    :customer_order_id => customer_order_again.id)
