class AddUniqueToTweet < ActiveRecord::Migration[5.0]
  def change
    remove_column :tweets, :tweet_id, :integer
    add_column :tweets, :tweet_id, :integer, :unique => true
    remove_column :tweets, :tweet, :string
    add_column :tweets, :tweet, :string, :unique => true, :length => 2000
  end
end
