# Destroying all Reviews first to avoid foreign key violation
p "Beware, for I am destroying all reviews!"
Review.destroy_all

# Now we destroy all Wigs
p "Beware, for I am destroying all wigs!"
Wig.destroy_all

# Create Users before creating wigs and reviews
p "Creating users..."
10.times do
  User.create!(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password123' # Assuming you are using a simple password for the seed
  )
end
p "10 users created!"

# Creates seed data for wigs
p "Seeding wigs..."
30.times do
  wig = Wig.create!(
    name: Faker::Creature::Dog.breed,
    material: ["synthetic", "natural"].sample,
    hair_style: ["curly", "afro", "straight"].sample,
    length: Faker::Creature::Dog.coat_length,
    address: ["Lyon", "Paris", "Marseille", "Grenoble"].sample,
    color: Faker::Color.color_name,
    price: rand(20..200),
    image: Faker::Avatar.image
  )

  # Create random reviews for the wig
  rand(3..7).times do
    user = User.order('RANDOM()').first  # Select a random user
    if user  # Ensure that we have a valid user
      Review.create!(
        comment: Faker::Lorem.sentence,
        rating: rand(1..5),
        user_id: user.id,  # Use user_id instead of user
        wig_id: wig.id     # Use wig_id instead of wig
      )
    end
  end
end

# Prints number of wigs seeded
p "#{Wig.count} wigs created!"
p "#{Review.count} reviews created!"
