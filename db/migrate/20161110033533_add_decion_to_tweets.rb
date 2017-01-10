class AddDecionToTweets < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :pn_flag, :boolean, :default => false
    add_column :tweets, :p_flag, :boolean, :default => false
    add_column :tweets, :n_flag, :boolean, :default => false
    add_column :tweets, :ne_flag, :boolean, :default => false
    add_column :tweets, :na_flag, :boolean, :default => false
    add_index :tweets, :pn_flag
    add_index :tweets, :p_flag
    add_index :tweets, :n_flag
    add_index :tweets, :ne_flag
    add_index :tweets, :na_flag
  end
end
