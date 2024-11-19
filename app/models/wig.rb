class Wig < ApplicationRecord
  validates :name, :material, :color, :hair_style, :length, :address, :price, :image,git pu presence: true
end
