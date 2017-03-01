Restaurant.delete_all

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

pera.restaurant.foods.create!(:name        => "Steak Tartare",
                              :description => "Dry aged steak with avocado.",
                              :price       => 45.0)

pera.restaurant.drinks.create!(:name        => "Rakija",
                               :description => "Strong alcholic beverage",
                               :price       => 10.0)

pera.employees.create!(:firstname             => "Ana",
                       :lastname              => "Spasic",
                       :email                 => "ana@gmail.com",
                       :password              => "anaspasic",
                       :password_confirmation => "anaspasic",
                       :password_changed      => true,
                       :confirmed_at          => Time.now,
                       :type                  => "Bartender",
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
                       :speciality            => "Testenine",
                       :type                  => 'Cook')

pera.restaurant.seats.create!(:area => "Garden I")
pera.restaurant.seats.create!(:area => "Garden II")
pera.restaurant.seats.create!(:area => "Garden III")

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
