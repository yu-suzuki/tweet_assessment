class AddTimeToEvaluation < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :start_at, :datetime, :null => false
    add_column :evaluations, :end_at, :datetime, :null => false
    add_column :evaluations, :elapsed, :integer, :null => false
    add_index :evaluations, :start_at
    add_index :evaluations, :end_at
    add_index :evaluations, :elapsed
  end
end
