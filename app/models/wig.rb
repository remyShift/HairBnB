class Wig < ApplicationRecord
  validates :name, :material, :color, :hair_style, :length, :address, :price, presence: true
end
