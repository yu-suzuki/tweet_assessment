class AddSourceToTweet < ActiveRecord::Migration[5.0]
  def change
    add_column :tweets, :source, :string
  end
end
