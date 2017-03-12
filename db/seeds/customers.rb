john = Customer.create!(:firstname => "John",
                        :lastname => "Doe",
                        :email => "johndoe@gmail.com",
                        :password => "johndoe",
                        :password_confirmation => "johndoe",
                        :confirmed_at => Time.now)

mick = Customer.create!(:firstname => "Mick",
                        :lastname => "Jagger",
                        :email => "mick@gmail.com",
                        :password => "gotmoves",
                        :password_confirmation => "gotmoves",
                        :confirmed_at => Time.now)

joe = Customer.create!(:firstname => "Joe",
                       :lastname => "Armstrong",
                       :email => "joe@gmail.com",
                       :password => "joejoe",
                       :password_confirmation => "joejoe",
                       :confirmed_at => Time.now)

# Friendships
john.friend_request(mick)
mick.accept_request(john)

john.friend_request(joe)
joe.accept_request(john)
