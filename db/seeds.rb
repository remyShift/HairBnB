require 'open-uri'
Faker::Config.locale = 'fr'

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

10.times do
  new_user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: 'password123',
  )

  image_url = user_image.sample
  new_user.profile_image.attach(io: URI.open(image_url), filename: "profile_image.jpg")

  if new_user.save
    rand(1..5).times do
    color = Faker::Color.color_name
    length = Wig::LENGTHS.sample
    hair_style = Wig::HAIRSTYLES.sample
    name = "#{Faker::Adjective.positive} #{length} wig"
      new_wig = Wig.new(
        name: name,
        material: Wig::MATERIALS.sample,
        hair_style: hair_style,
        length: length,
        address: "#{Faker::Address.full_address}, France",
        color: color,
        price: rand(20..200),
        user_id: new_user.id
      )

      image_url = cloudinary_images.sample
      new_wig.wig_image.attach(io: URI.open(image_url), filename: "wig_image.jpg")

      unless new_wig.save
        p "Failed to save wig: #{new_wig.errors.full_messages.join(", ")}"
      end
    end
  else
    p "Failed to save user: #{new_user.errors.full_messages.join(", ")}"
  end
end

Wig.find_each do |wig|
  rand(3..7).times do
    Review.create(
      comment: Faker::Lorem.paragraph,
      rating: rand(1..5),
      user_id: User.order('RANDOM()').first.id,
      wig_id: wig.id
    )
  end
end

p "-----------------Seeding completed----------------"
p "#{User.count} users created who post #{Wig.count} wigs !"
