class CreatePointRates < ActiveRecord::Migration[5.0]
  def change
    create_table :point_rates do |t|
      t.integer :user_id, :null => false
      t.float :rating, :null => false

      t.timestamps
    end
    add_index :point_rates, :user_id
  end
end
