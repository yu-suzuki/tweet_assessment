class RemoveTweetUserFromTweets < ActiveRecord::Migration[5.0]
  def change
    remove_column :tweets, :tweet_user, :string
    remove_column :tweets, :tweet_user_id, :string
    add_column :tweets, :tweet_user_id, :integer
  end
end
