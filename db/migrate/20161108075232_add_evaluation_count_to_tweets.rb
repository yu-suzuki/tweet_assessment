class AddEvaluationCountToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :evaluation_count, :integer, :default => 0
    add_index :tweets, :evaluation_count
  end
end
