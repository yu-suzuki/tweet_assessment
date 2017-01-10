class AddNeutralToEvaluations < ActiveRecord::Migration[5.0]
  def change
    remove_column :evaluations, :positive
    remove_column :evaluations, :negative
    add_column :evaluations, :neutral, :boolean, :default => false
    add_column :evaluations, :positive, :boolean, :default => false
    add_column :evaluations, :negative, :boolean, :default => false
    add_index :evaluations, :positive
    add_index :evaluations, :negative
    add_index :evaluations, :neutral
  end
end
