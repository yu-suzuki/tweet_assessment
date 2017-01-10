class CreateRedCards < ActiveRecord::Migration[5.0]
  def change
    create_table :red_cards do |t|
      t.integer :from_user_id, :null => false
      t.integer :to_user_id, :null => false
      t.integer :evaluation, :null => false
      t.string :comment, :null => false
      t.boolean :read_flag, :default => false

      t.timestamps
    end
    add_index :red_cards, [:from_user_id, :to_user_id], :unique => true
    add_index :red_cards, :from_user_id
    add_index :red_cards, :to_user_id
  end
end
