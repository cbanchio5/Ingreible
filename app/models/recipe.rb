class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :favourites
  has_one_attached :photo
end
