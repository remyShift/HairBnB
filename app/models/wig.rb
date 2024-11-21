class Wig < ApplicationRecord
  LENGTHS = ["very short", "short", "shoulder length", "long", "very long"]
  MATERIALS = ["natural", "synthetic"]
  HAIRSTYLES = ["straight", "curly", "wavy", "afro"]

  belongs_to :user
  has_many :reviews
  has_many :bookings
  has_one_attached :wig_image
  geocoded_by :address

  validates :name, :material, :color, :hair_style, :length, :address, :price, :wig_image, presence: true
  validates :length, inclusion: { in: LENGTHS,
    message: "%{value} is not a valid length" }
  validates :material, inclusion: { in: MATERIALS,
    message: "%{value} is not a valid length" }
  validates :hair_style, inclusion: { in: HAIRSTYLES,
    message: "%{value} is not a valid length" }

    after_validation :geocode, if: :will_save_change_to_address?
end
