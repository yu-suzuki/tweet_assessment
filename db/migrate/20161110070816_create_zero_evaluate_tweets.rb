class CreateZeroEvaluateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :zero_evaluate_tweets do |t|
      t.integer :tweet_id, :null => false

      t.timestamps
    end
  end
end
