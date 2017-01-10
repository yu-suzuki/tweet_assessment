class AddScreenNameToTweetUser < ActiveRecord::Migration[5.0]
  def change
    add_column :tweet_users, :screen_name, :string
  end
end
