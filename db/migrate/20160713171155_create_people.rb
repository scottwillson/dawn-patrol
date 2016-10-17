class CreatePeople < ActiveRecord::Migration[5.0]
  def change
    create_table :people do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.string :name
      t.integer :racing_on_rails_id

      t.index :name
      t.index :racing_on_rails_id

      t.timestamps
    end
  end
end
