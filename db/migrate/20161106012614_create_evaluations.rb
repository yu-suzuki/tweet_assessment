class CreateEvaluations < ActiveRecord::Migration[5.0]
  def change
    create_table :evaluations do |t|
      t.integer :user_id
      t.integer :tweet_id
      t.integer :positive
      t.integer :negative

      t.timestamps
    end
    add_index :evaluations, :user_id
    add_index :evaluations, :tweet_id
    add_index :evaluations, :positive
    add_index :evaluations, :negative
  end
end
