class CreateAspects < ActiveRecord::Migration[5.0]
  def change
    create_table :aspects do |t|
      t.integer :evaluation_id
      t.string :subj
      t.string :target

      t.timestamps
    end
    add_index :aspects, :evaluation_id
  end
end
