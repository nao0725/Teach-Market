class AddRateToComment < ActiveRecord::Migration[5.2]
  def change
    add_column :comments, :rate, :float
  end
end
