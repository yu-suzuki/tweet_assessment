class CreatePoints < ActiveRecord::Migration[5.0]
  def change
    create_table :points do |t|
      t.integer :user_id
      t.integer :tweet_id

      t.timestamps
    end
    add_index :points, [:user_id, :tweet_id], :unique => true
  end
end
