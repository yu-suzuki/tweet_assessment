class AddMemoToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :memo, :string
  end
end
