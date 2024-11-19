require 'faker'
# Destroying all Wigs
p "Beware, for I am destroying all wigs!"
Wig.destroy_all

# Creates seed
p "Seeding"
30.times do
  wig = Wig.new( name: Faker::Creature::Dog.breed,
           material: ["synthetic", "natural"].sample,
           hair_style: ["curly", "afro", "straight"].sample,
           length: Faker::Creature::Dog.coat_length,
           address: ["Lyon", "Paris", "Marseille", "Grenoble"].sample,
           color: Faker::Color.color_name,
           price: rand(20..200),
           image: Faker::Avatar.image
        )
  wig.save!
end
# Prints number of wigs seeded
p "#{Wig.count} wigs created !"
