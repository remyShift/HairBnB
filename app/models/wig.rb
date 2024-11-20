class Wig < ApplicationRecord
  has_one_attached :wig_image

  validates :name, :material, :color, :hair_style, :length, :address, :price, :image, presence: true
end
