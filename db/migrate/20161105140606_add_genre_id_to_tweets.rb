class AddGenreIdToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :tweet_date, :datetime
    add_column :tweets, :tweet_id, :integer
    add_column :tweets, :tweet_user, :string
    add_column :tweets, :tweet_user_id, :integer
    add_column :tweets, :genre_id, :integer
  end
end
