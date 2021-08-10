class AddRateToReview < ActiveRecord::Migration[5.2]
  def change
    add_column :reviews, :rate, :float
  end
end
