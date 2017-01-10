class AddEvaluationIdToPoint < ActiveRecord::Migration[5.0]
  def change
    add_column :points, :evaluation_id, :integer, :unique => true
  end
end
