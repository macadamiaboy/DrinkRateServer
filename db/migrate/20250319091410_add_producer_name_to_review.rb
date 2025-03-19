class AddProducerNameToReview < ActiveRecord::Migration[7.2]
  def change
    add_column :reviews, :producer, :string
    add_column :reviews, :abv, :float
  end
end
