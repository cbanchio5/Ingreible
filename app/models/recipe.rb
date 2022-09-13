class Recipe < ApplicationRecord
  belongs_to :user
  has_many :reviews
  has_many :favourites
  has_one_attached :photo

  include PgSearch::Model
  pg_search_scope :search_by_name_and_ingredients,
    against: [ :name, :ingredients ],
    using: {
      tsearch: { prefix: true }
    }

end
