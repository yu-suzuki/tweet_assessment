class AddDecisionToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :decision, :integer, :default => -1
    add_index :tweets, :decision
  end
end
