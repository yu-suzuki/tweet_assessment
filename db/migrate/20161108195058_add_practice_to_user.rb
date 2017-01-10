class AddPracticeToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :practice, :boolean, :default => false
    add_column :users, :team, :integer, :default => 0
  end
end
