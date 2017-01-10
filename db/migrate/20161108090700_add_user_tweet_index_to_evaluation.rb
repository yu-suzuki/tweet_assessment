class AddUserTweetIndexToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_index :evaluations, [:user_id, :tweet_id], :unique => true
  end
end
