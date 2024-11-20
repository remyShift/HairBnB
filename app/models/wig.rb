class Wig < ApplicationRecord
  has_many :reviews
  validates :name, :material, :color, :hair_style, :length, :address, :price, :image, presence: true
end
