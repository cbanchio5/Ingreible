class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :reviews
  has_many :messages
  has_many :recipes
  has_many :memberships
  has_many :communities, through: :memberships
  has_many :favourites
  has_one_attached :photo
end
