Restaurant.delete_all
Food.delete_all
Drink.delete_all
Seat.delete_all

restaurant = Restaurant.create(title: "Black Swan", description: "very famous restaurant,
                  it's in top 5 restaurant in the city")
restaurant.foods.create(name: "Pancakes", description: "is delicious sweets", price: "130")
restaurant.drinks.create(name: "Vodka", description: "is very strong alcohol", price: "200")
restaurant.seats.create(number: 20, area: "Beach 3")
