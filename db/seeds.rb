require 'open-uri'

# Destroying all Reviews first to avoid foreign key violation
p "Beware, for I am destroying all reviews!"
Review.destroy_all

# Now we destroy all Wigs
p "Beware, for I am destroying all wigs!"
Wig.destroy_all

# Destroy all Users
p "Beware, for I am destroying all users!"
User.destroy_all

# Create Users before creating wigs and reviews
p "Creating users..."

user_image = [
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732113474/djfmtvqr0abnl4ysyjxu.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732113423/fw1eodldytttrpdmuoha.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732113389/h1bjhjdgcrmq3mdmrq7q.jpg",
]

10.times do
  new_user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password123',
  )

  image_url = user_image.sample
  new_user.profile_image.attach(io: URI.open(image_url), filename: "profile_image.jpg")
  new_user.save
end
p "10 users created!"

# Creates seed data for wigs
p "Seeding wigs..."

cloudinary_images = [
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110869/paxd7lrtjwfntf3myp7f.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110863/a0jmcil2dvho2uclogp7.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110855/cpza2zqbszk5nlz3jgf1.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110843/jx56acb0scpuuaomiqwz.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110830/vvs7dkqttcnhwqw2a03z.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110819/lts4wrsbgrgxyuksigcp.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110810/k3pi1arlpspbckvfzqyk.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110799/fillm8o7syqkgu3kkzhb.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110791/iotctg4b6c7c4lr7paca.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110779/o1ks9u9bnbngpdqpfli6.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110768/ywcy1xhqvg3v88vdmq3e.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732110756/prrhqp0necza5zlnfcec.jpg",
  "https://res.cloudinary.com/dmqwigubs/image/upload/v1732109193/pzz0mryvwyuehof8awbx.jpg",
]


30.times do
  new_wig = Wig.new(
    name: Faker::Creature::Dog.breed,
    material: Wig::MATERIALS.sample,
    hair_style: Wig::HAIRSTYLES.sample,
    length: Wig::LENGTHS.sample,
    address: ["Lyon", "Paris", "Marseille", "Grenoble"].sample,
    color: Faker::Color.color_name,
    price: rand(20..200),
  )
  image_url = cloudinary_images.sample
  new_wig.wig_image.attach(io: URI.open(image_url), filename: "wig_image.jpg")

  if new_wig.save
    # Create random reviews for the wig only if the wig is saved
    rand(3..7).times do
      user = User.order('RANDOM()').first
      if user
        Review.create!(
          comment: Faker::Lorem.sentence,
          rating: rand(1..5),
          user_id: user.id,
          wig_id: new_wig.id
        )
      end
    end
  else
    p "Failed to save wig: #{new_wig.errors.full_messages.join(", ")}"
  end
end

p "#{Wig.count} wigs created!"
p "#{Review.count} reviews created!"
