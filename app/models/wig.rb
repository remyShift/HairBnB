class Wig < ApplicationRecord
  LENGTHS = ["very short", "short", "shoulder length", "long", "very long"]
  MATERIALS = ["natural", "synthetic"]
  HAIRSTYLES = ["straight", "curly", "wavy", "afro"]

  has_many :reviews
 
  validates :name, :material, :color, :hair_style, :length, :address, :price, :image, presence: true
  validates :length, inclusion: { in: LENGTHS,
    message: "%{value} is not a valid length" }
  validates :material, inclusion: { in: MATERIALS,
    message: "%{value} is not a valid length" }
  validates :hair_style, inclusion: { in: HAIRSTYLES,
    message: "%{value} is not a valid length" }
end
