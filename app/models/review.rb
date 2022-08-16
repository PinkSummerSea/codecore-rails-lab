class Review < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :likes
  has_many :likers, through: :likes, source: :user

  validates :rating, numericality: { only_integer: true, greater_than_or_equal_to: 1, less_than_or_equal_to: 5 }
end
