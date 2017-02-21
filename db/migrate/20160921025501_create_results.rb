class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :event_category
      t.belongs_to :person

      t.string :place, default: "", null: false
      t.float :points, null: false, default: 0
      t.integer :racing_on_rails_id
      t.float :time

      t.index :racing_on_rails_id

      t.timestamps
    end
  end
end
