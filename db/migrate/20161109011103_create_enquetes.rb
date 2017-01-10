class CreateEnquetes < ActiveRecord::Migration[5.0]
  def change
    create_table :enquetes do |t|
      t.string :sex, :null => false
      t.integer :age, :null => false
      t.string :place, :null => false
      t.string :job, :null => false
      t.string :machine, :null => false
      t.integer :user_id, :null => false
      t.string :motivation, :null => false

      t.timestamps
    end

    add_index :enquetes, :user_id
  end
end
