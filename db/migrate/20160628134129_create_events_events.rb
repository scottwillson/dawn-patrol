class CreateEventsEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events_events do |t|
      t.datetime :starts_at
      t.string :discipline
      t.string :city
      t.string :name
      t.string :promoter_name
      t.string :phone
      t.string :state

      t.timestamps
    end
  end
end
