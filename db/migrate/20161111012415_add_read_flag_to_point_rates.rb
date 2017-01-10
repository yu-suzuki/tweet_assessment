class AddReadFlagToPointRates < ActiveRecord::Migration[5.0]
  def change
    add_column :point_rates, :read_flag, :boolean, :default => false
  end
end
