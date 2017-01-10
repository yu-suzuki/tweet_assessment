class CreateTweetUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :tweet_users do |t|
      t.integer :user_id
      t.string :user_name

      t.timestamps
    end
    add_index :tweet_users, :user_id, :unique => true
    add_index :tweet_users, :user_name
  end
end
