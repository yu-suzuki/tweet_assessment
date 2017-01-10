class AddNaToEvaluations < ActiveRecord::Migration[5.0]
  def change
    add_column :evaluations, :na, :boolean
  end
end
