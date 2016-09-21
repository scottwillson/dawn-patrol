class CreateEventsEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events_events do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :discipline, null: false
      t.belongs_to :calculation

      t.datetime :starts_at, null: false
      t.string :city
      t.string :name, null: false, default: "New Event"
      t.integer :racing_on_rails_id
      t.string :phone
      t.string :state

      t.index :starts_at
      t.index :name

      t.timestamps
    end
  end
end
