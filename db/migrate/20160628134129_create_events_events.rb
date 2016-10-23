class CreateEventsEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events_events do |t|
      t.belongs_to :dawn_patrol_association, null: false
      t.belongs_to :discipline, null: false
      t.belongs_to :calculation
      t.belongs_to :parent

      t.datetime :starts_at, null: false
      t.string :city
      t.string :name, null: false, default: "New Event"
      t.integer :racing_on_rails_id
      t.string :phone
      t.string :slug, null: false
      t.string :state

      t.index [ :dawn_patrol_association_id, :slug ], unique: true
      t.index :name
      t.index :racing_on_rails_id
      t.index :starts_at

      t.timestamps
    end
  end
end
