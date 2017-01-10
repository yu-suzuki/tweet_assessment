class CreateAddRateToPoints < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :rate, :float, :default => 1.0, :null => false
  end
end
