class CreateTaskQueues < ActiveRecord::Migration[5.0]
  def change
    create_table :task_queues do |t|
      t.integer :tweet_id, :unique => true
      t.integer :user_id, :unique => true

      t.timestamps
    end
  end
end
