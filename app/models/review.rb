class Review < ApplicationRecord
  has_many_attached :images

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  
end
