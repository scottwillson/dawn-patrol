class CreateEventsEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events_events do |t|
      t.time :datetime
      t.string :discipline
      t.string :location
      t.string :name
      t.string :promoter_name
      t.string :phone

      t.timestamps
    end
  end
end
