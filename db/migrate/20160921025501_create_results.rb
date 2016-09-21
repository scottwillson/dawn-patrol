class CreateResults < ActiveRecord::Migration[5.0]
  def change
    create_table :results do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :event_category
      t.belongs_to :person
      t.decimal :points, precision: 10, scale: 0, null: false, default: 0

      t.timestamps
    end
  end
end
