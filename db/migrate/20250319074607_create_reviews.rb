class CreateReviews < ActiveRecord::Migration[7.2]
  def change
    create_table :reviews do |t|
      t.string :name
      t.integer :rating
      t.integer :price
      t.text :description

      t.timestamps
    end
  end
end
