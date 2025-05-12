class User < ApplicationRecord
  has_secure_password

  before_destroy :delete_users_reviews

  has_many :reviews
  has_one_attached :profile_picture

  private
  def delete_users_reviews
    self.reviews.each { _1.destroy }
  end
end
