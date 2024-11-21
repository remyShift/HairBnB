class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :wigs
  has_one_attached :profile_image
  has_many :wigs
  has_many :bookings

  validates :first_name, :last_name, :email, :password, presence: true
  validates :email, uniqueness: true
end
