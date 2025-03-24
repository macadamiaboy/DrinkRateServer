class Review < ApplicationRecord
  has_many_attached :images
  belongs_to :user

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 10 }
  validates :abv, numericality: true, format: { with: /\A\d+(\.\d{1})?\z/, message: "Значение должно быть числом с максимум одним знаком после запятой" }
  validates :producer, presence: true, length: { minimum: 1 }
  validates :name, presence: true, length: { minimum: 1 }
end
