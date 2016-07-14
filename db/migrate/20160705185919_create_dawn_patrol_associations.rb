class CreateDawnPatrolAssociations < ActiveRecord::Migration[5.0]
  def change
    create_table :dawn_patrol_associations do |t|
      t.string :acronym, null: false, default: "CBRA", unique: true
      t.string :host, null: false, default: "localhost|0.0.0.0|127.0.0.1|::1|test.host", unique: true
      t.string :name, null: false, default: "Cascadia Bicycle Racing Association", unique: true

      t.index :acronym, unique: true
      t.index :host, unique: true
      t.index :name, unique: true

      t.timestamps
    end
  end
end
