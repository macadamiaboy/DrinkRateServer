class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :login
      t.string :name

      t.timestamps
    end
  end
end
