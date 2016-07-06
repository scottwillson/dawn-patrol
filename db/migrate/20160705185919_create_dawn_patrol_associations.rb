class CreateDawnPatrolAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :dawn_patrol_associations do |t|
      t.string :key, null: false
      t.string :name, null: false

      t.index :key

      t.timestamps
    end
  end
end
