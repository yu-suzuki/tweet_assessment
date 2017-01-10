class AddColumnsToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :pn_count, :integer, :default => 0
    add_column :tweets, :p_count, :integer, :default => 0
    add_column :tweets, :n_count, :integer, :default => 0
    add_column :tweets, :ne_count, :integer, :default => 0
    add_column :tweets, :na_count, :integer, :default => 0
    add_index :tweets, :pn_count
    add_index :tweets, :p_count
    add_index :tweets, :n_count
    add_index :tweets, :ne_count
    add_index :tweets, :na_count
    add_index :tweets, :genre_id
    add_index :tweets, :tweet_user_id
    add_index :tweets, :tweet_id

  end
end
