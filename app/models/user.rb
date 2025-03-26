class User < ApplicationRecord
  before_destroy :delete_users_reviews

  has_many :reviews

  private
  def delete_users_reviews
    self.reviews.each { _1.destroy }
  end
end
